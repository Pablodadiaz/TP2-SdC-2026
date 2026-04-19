#include <stdio.h>

// 1. Le avisamos a C que esta función existe en nuestro archivo Ensamblador
extern int convertir_y_sumar(float gini);

// 2. Esta es la función que Python llama
int procesar_gini(float gini_float) {
    printf("\n  --- Llamando función en C ---\n");
    printf("  [C] Valor float recibido de Python: %.2f\n", gini_float);
    printf("  [C] Delegando cálculo a Ensamblador...\n");
    
    // 3. C ya no hace la suma. Llama a Ensamblador y le pasa el parámetro.
    int resultado_final = convertir_y_sumar(gini_float);
    
    printf("  [C] Resultado devuelto por Ensamblador (+1): %d\n\n", resultado_final);
    
    // 4. Devolvemos el valor final a Python
    return resultado_final; 
}
