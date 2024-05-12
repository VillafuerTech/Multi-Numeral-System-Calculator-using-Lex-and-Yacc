%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);
%}

%union {
    double val;
}

%token <val> NUMBER
%token PLUS MINUS TIMES DIVIDE
%token LP RP
%token NEWLINE  // Declarar el token NEWLINE
%token ERROR

%type <val> expression

%left PLUS MINUS
%left TIMES DIVIDE

%%

calculation:
    | calculation expression NEWLINE { printf("Resultado: %f\n", $2); }
    | calculation expression ERROR NEWLINE { fprintf(stderr, "Expresión inválida.\n"); }
    ;

expression:
    NUMBER
  | expression PLUS expression { $$ = $1 + $3; }
  | expression MINUS expression { $$ = $1 - $3; }
  | expression TIMES expression { $$ = $1 * $3; }
  | expression DIVIDE expression { $$ = $1 / $3; }
  | LP expression RP { $$ = $2; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Ingrese una expresión:\n");
    yyparse();
    return 0;
}
