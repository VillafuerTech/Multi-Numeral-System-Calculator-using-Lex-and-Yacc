%{
#include <stdio.h>
#include <stdlib.h> // Para uso de atof, si necesario.
void yyerror(const char *s);
int yylex(void);
%}

%union {
    double val;  // Esto almacenará los valores numéricos de las expresiones
}

%token <val> NUMBER
%token PLUS MINUS TIMES DIVIDE
%token LP RP
%token ERROR

%type <val> expression  // Declara que 'expression' usa la parte 'val' de la unión

%left PLUS MINUS
%left TIMES DIVIDE

%%

calculation:
    expression { printf("Resultado: %f\n", $1); }
  ;

expression:
    NUMBER { $$ = $1; }
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
    while (1) {
        if (yyparse() == 0) {
            printf("Nueva expresión:\n");
        } else {
            break;
        }
    }
    return 0;
}
