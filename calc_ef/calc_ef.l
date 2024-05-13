%{
#include "calc-ef.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+(\.[0-9]+)?   { yylval.val = atof(yytext); return NUMBER; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return TIMES; }
"/"                 { return DIVIDE; }
"("                 { return LP; }
")"                 { return RP; }
"\n"                { return NEWLINE; }
[ \t]+            { /* Ignorar espacios en blanco */ }
.                   { printf("Carácter inesperado: %c\n", *yytext); return ERROR; }

%%

int yywrap(void) {
    return 1;
}
