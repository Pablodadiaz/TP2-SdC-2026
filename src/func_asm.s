global convertir_y_sumar

section .text

convertir_y_sumar:
    ; --- 1. PRÓLOGO: Armamos el Stack Frame ---
    push rbp
    mov rbp, rsp
    sub rsp, 16

    ; --- 2. PASO DE PARÁMETROS ---
    movss [rbp-4], xmm0 

    ; --- 3. CÁLCULO (Conversión a entero) ---
    cvttss2si eax, [rbp-4] 

    ; --- 4. SUMAR 1 ---
    add eax, 1

    ; --- 5. EPÍLOGO: Desarmamos el Stack Frame ---
    mov rsp, rbp
    pop rbp
    ret

; Línea de seguridad para evitar advertencias de compilación
section .note.GNU-stack noalloc noexec nowrite progbits
