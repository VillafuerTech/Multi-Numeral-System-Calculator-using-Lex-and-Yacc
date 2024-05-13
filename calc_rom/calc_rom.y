%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char *s);
int yylex(void);
char* to_roman(int value);

%}

%token NUMBER PLUS MINUS TIMES DIVIDE LP RP ERROR NEWLINE

%left PLUS MINUS
%left TIMES DIVIDE

%%
calculation:
    | calculation expression NEWLINE { printf("Resultado: %s\n", to_roman($2)); }
    | calculation ERROR NEWLINE { fprintf(stderr, "Expresión inválida.\n"); }

expression:
    NUMBER
  | expression PLUS expression   { $$ = $1 + $3; }
  | expression MINUS expression  { $$ = $1 - $3; }
  | expression TIMES expression  { $$ = $1 * $3; }
  | expression DIVIDE expression { $$ = $1 / $3; }
  | LP expression RP             { $$ = $2; }

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Ingrese una expresión en números romanos:\n");
    yyparse();
    return 0;
}

char* to_roman(int value) {
    static char buffer[1024]; // Buffer principal para el número romano
    int original_value = value; // Guardar el valor original para comprobar si es negativo
    buffer[0] = '\0'; // Limpiar el buffer

    struct roman {
        int value;
        char const* numeral;
    } numerals[] = {
        {1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"},
        {100, "C"}, {90, "XC"}, {50, "L"}, {40, "XL"},
        {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"},
        {0, NULL} // Terminador
    };

    if (value < 0) {
        value = -value; // Convertir a positivo si es negativo
    }

    for (struct roman* current = numerals; current->value > 0; ++current) {
        while (value >= current->value) {
            strcat(buffer, current->numeral);
            value -= current->value;
        }
    }

    if (original_value < 0) {
        static char negative_buffer[1025]; // Incrementar el tamaño para evitar truncamiento
        snprintf(negative_buffer, sizeof(negative_buffer), "-%s", buffer);
        strcpy(buffer, negative_buffer);
    }

    return buffer;
}
