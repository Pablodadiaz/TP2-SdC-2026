// gini_calc.c

#include <stdio.h>

// Recibe un float (el índice GINI), lo convierte a entero y le suma 1
// La función debe ser exportable, por eso no tiene "static"
long procesar_gini(double gini_float) {
    
    // Paso 1: convertir float a entero (trunca los decimales)
    long gini_entero = (long)gini_float;
    
    printf("[C] Valor float recibido:   %.2f\n", gini_float);
    printf("[C] Convertido a entero:    %ld\n", gini_entero);
    
    // Paso 2: sumar +1 como pide la consigna
    long resultado = gini_entero + 1;
    
    printf("[C] Resultado final (+1):   %ld\n", resultado);
    
    // El valor de retorno queda en %rax (lo verás en la iteración 2 con GDB)
    return resultado;
}