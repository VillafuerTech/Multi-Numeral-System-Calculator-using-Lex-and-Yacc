%{
#include "calc_rom.tab.h"
#include <stdlib.h>
#include <string.h>

int roman_to_int(char * roman);
%}

%%

[MDCLXVI]+  { yylval = roman_to_int(yytext); return NUMBER; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return TIMES; }
"/"         { return DIVIDE; }
"("         { return LP; }
")"         { return RP; }
"\n"        { return NEWLINE; }
[ \t]+     { /* Ignorar espacios en blanco */ }
.            { printf("Carácter inesperado: %c\n", *yytext); return ERROR; }

%%
int yywrap(void) {
    return 1;
}
int roman_to_int(char *roman) {
    int num = 0;
    int prev_value = 0; // Guarda el valor numérico del símbolo romano anterior
    int current_value = 0; // Guarda el valor numérico del símbolo romano actual
    int repeat_count = 1; // Cuenta las repeticiones de caracteres

    for (int i = strlen(roman) - 1; i >= 0; i--) { // Procesa de atrás hacia adelante
        char c = roman[i];
        switch (c) {
            case 'I': current_value = 1; break;
            case 'V': current_value = 5; break;
            case 'X': current_value = 10; break;
            case 'L': current_value = 50; break;
            case 'C': current_value = 100; break;
            case 'D': current_value = 500; break;
            case 'M': current_value = 1000; break;
            default: 
                printf("Carácter inválido '%c' en número romano.\n", c);
                return -1; // Retorna -1 para indicar un error
        }

        if (current_value < prev_value) {
            // Si el valor actual es menor que el anterior, verifica la legalidad de la sustracción
            if (!((prev_value == 5 || prev_value == 10) && current_value == 1) &&
                !((prev_value == 50 || prev_value == 100) && current_value == 10) &&
                !((prev_value == 500 || prev_value == 1000) && current_value == 100)) {
                printf("Número romano mal formado en sustracción con '%c'.\n", c);
                return -1; // Retorna -1 para indicar un error
            }
            repeat_count = 1; // Resetear la cuenta de repetición después de una sustracción válida
        } else if (current_value == prev_value) {
            repeat_count++;
            if (repeat_count > 3) {
                printf("Número romano tiene más de tres repeticiones consecutivas de '%c'.\n", c);
                return -1; // Retorna -1 para indicar un error
            }
        } else {
            repeat_count = 1; // Resetear la cuenta de repetición
        }
        num += current_value; // Aplica suma
        prev_value = current_value; // Actualiza el valor previo para la próxima iteración
    }

    return num;
}
