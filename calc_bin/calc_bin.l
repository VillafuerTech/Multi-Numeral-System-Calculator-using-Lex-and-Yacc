%{
#include "calc_bin.tab.h"
#include <stdlib.h>
%}

%%
[01]+ { yylval.val = strtol(yytext, NULL, 2); return NUMBER; } // Convierte binario a entero
"+"   { return PLUS; }
"-"   { return MINUS; }
"*"   { return TIMES; }
"/"   { return DIVIDE; }
"("   { return LP; }
")"   { return RP; }
"\n"  { return NEWLINE; }
[ \t]+ { /* Ignorar espacios en blanco */ }
.     { printf("Carácter inesperado: %c\n", *yytext); return ERROR; }

%%
int yywrap(void) {
    return 1;
}
