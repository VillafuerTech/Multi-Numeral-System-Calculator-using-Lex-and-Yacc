%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h> // Incluir la biblioteca para usar strcpy
void yyerror(const char *s);
int yylex(void);

char* to_binary(int num);
%}

%union {
    int val;
}

%token <val> NUMBER
%token PLUS MINUS TIMES DIVIDE
%token LP RP
%token NEWLINE
%token ERROR

%type <val> expression

%left PLUS MINUS
%left TIMES DIVIDE

%%
calculation:
    | calculation expression NEWLINE { printf("Resultado: %s\n", to_binary($2)); }
    | calculation expression ERROR NEWLINE { fprintf(stderr, "Expresión inválida.\n"); }

expression:
    NUMBER
  | expression PLUS expression { $$ = $1 + $3; }
  | expression MINUS expression { $$ = $1 - $3; }
  | expression TIMES expression { $$ = $1 * $3; }
  | expression DIVIDE expression { $$ = $1 / $3; }
  | LP expression RP { $$ = $2; }

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Ingrese una expresión en binario:\n");
    yyparse();
    return 0;
}

char* to_binary(int num) {
    static char bin_str[33];
    int i = 0;
    if (num == 0) {
        strcpy(bin_str, "0");
        return bin_str;
    }
    for (i = 31; i >= 0; i--) {
        bin_str[i] = (num & 1) + '0';
        num >>= 1;
    }
    // Ignorar ceros no significativos
    char *p = bin_str;
    while (*p == '0') p++;
    return p;
}
