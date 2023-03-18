/*
    filename: lexer.l
*/

/* Definition section */
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define YY_NO_UNPUT
    #define YY_NO_INPUT
    #define print_token(token) \
        printf("%-8s \t %s\n", strcmp(token, "NEWLINE")? yytext: "", token)

    int line_num = 0;
    int comment_num = 0;
    int last_comment_line = -1;
%}


/* Define regular expression label */
letter [a-zA-Z_]
digit [0-9]

/* Rules section */
%%
{digit}+    { print_token("INT_LIT");}
{digit}+"."{digit}+ {print_token("FLOAT_LIT");}

"+"         { print_token("ADD"); }
"-"         { print_token("SUB"); }
"*"         { print_token("MUL"); }
"/"         { print_token("QUO"); }
"%"         { print_token("REM"); }
">"         { print_token("GTR"); }
"<"         { print_token("LSS"); }
">="         { print_token("GEQ"); }
"<="         { print_token("LEQ"); }
"=="         { print_token("EQL"); }
"!="         { print_token("NEQ"); }
"="         { print_token("ASSIGN"); }
"+="         { print_token("ADD_ASSIGN"); }
"-="         { print_token("SUB_ASSIGN"); }
"*="         { print_token("MUL_ASSIGN"); }
"/="         { print_token("QUO_ASSIGN"); }
"%="         { print_token("REM_ASSIGN"); }
"&"         { print_token("BAND"); }
"|"         { print_token("BOR"); }
"~"         { print_token("BNOT"); }
">>"         { print_token("RSHIFT"); }
"&&"         { print_token("LAND"); }
"||"         { print_token("LOR"); }
"!"         { print_token("NOT"); }
"("         { print_token("LPAREN"); }
")"         { print_token("RPAREN"); }
"["         { print_token("LBRACK"); }
"]"         { print_token("RBRACK"); }
"{"         { print_token("LBRACE"); }
"}"         { print_token("RBRACE"); }
";"         { print_token("SEMICOLON"); }
","         { print_token("COMMA"); }
"\""         { print_token("QUATA"); }
"\n"         { print_token("NEWLINE"); line_num++; }
":"         { print_token("COLON"); }

<<EOF>>     { line_num++; yyterminate(); }
[ \t]+      {;}
.           {;}
%%

/*  C Code section */
int yywrap(void)
{
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    } else {
        yyin = stdin;
    }

    yylex();
    printf("\nFinish scanning,\n");
    printf("total line: %d\n", line_num);
    printf("comment line: %d\n", comment_num);
    fclose(yyin);
    return 0;
}
