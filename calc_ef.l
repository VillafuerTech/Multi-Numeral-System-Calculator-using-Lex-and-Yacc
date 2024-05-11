%{
#include "y.tab.h"
%}

%%

[0-9]+(\.[0-9]+)?   { yylval = atof(yytext); return NUMBER; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return TIMES; }
"/"                 { return DIVIDE; }
"("                 { return LP; }
")"                 { return RP; }
[ \t\n]+            { /* ignore whitespace */ }
.                   { printf("Unexpected character: %c\n", *yytext); }

%%

int yywrap(void) {
    return 1;
}
