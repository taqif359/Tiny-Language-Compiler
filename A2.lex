import java.io.*;
%%
%{    

    static int arr[] = {0,0,0,0,0};


    public static void main(String argv[]) throws IOException {
        while((new A2( new FileReader("A2.input"))).yylex() >= 0){};

        BufferedWriter out = new BufferedWriter(new FileWriter("A2.output"));

        out.write("identifiers: " + arr[0] + "\n" +
        "keywords: " + arr[1] + "\n" +
        "numbers: " + arr[2] + "\n" +
        "comments: " + arr[3] + "\n" +
        "quotedString: " + arr[4] + "\n");
        out.close();
    }

%}

%notunix
%integer
%type void
%class A2
%eofval{return;
%eofval}


%state COMMENT

%%

<YYINITIAL>"/**" {yybegin(COMMENT);}
<COMMENT>"**/" {yybegin(YYINITIAL); arr[3]++;}

<YYINITIAL>\"[^\"]*\" {arr[4]++;}

<YYINITIAL>WRITE|READ|IF|ELSE|RETURN|BEGIN|END|MAIN|STRING|INT|REAL {arr[1]++;}
<YYINITIAL>[a-zA-Z][a-zA-Z0-9]* {arr[0]++;}
<YYINITIAL>[0-9]+\.?[0-9]* {arr[2]++;}

\n|\r|.  {}