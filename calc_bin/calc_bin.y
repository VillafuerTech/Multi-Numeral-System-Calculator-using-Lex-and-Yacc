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
    static char bin_str[34]; // Buffer para 33 caracteres + '\0'
    int is_negative = (num < 0);
    int index = 32;

    bin_str[33] = '\0'; // Terminador nulo para la cadena

    if (num == 0) {
        return "0";
    }

    // Convertir el número a positivo si es negativo
    if (is_negative) {
        num = -num;
    }

    // Convertir el número a binario
    while (num > 0 && index >= 0) {
        bin_str[index--] = (num & 1) + '0';
        num >>= 1;
    }

    char *start = bin_str + index + 1;  // Empezar la cadena después de los últimos bits llenados

    if (is_negative) {
        // Si es negativo, desplazar todo un lugar para el signo negativo
        memmove(start + 1, start, strlen(start) + 1);
        start[0] = '-';
    }

    return start;
}
