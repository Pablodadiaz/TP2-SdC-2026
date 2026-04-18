.section .rodata
    fmt_double: .string "[ASM] Valor double recibido:  %.2f\n"
    fmt_int:    .string "[ASM] Convertido a entero:    %ld\n"
    fmt_result: .string "[ASM] Resultado final (+1):   %ld\n"

.text
.global func_asm
.type func_asm, @function

func_asm:
    # ---------------------------------------------------------
    # 1. PRÓLOGO Y ALINEACIÓN DE PILA
    # ---------------------------------------------------------
    pushq   %rbp            
    movq    %rsp, %rbp      
    
    pushq   %rbx            # Resguardamos %rbx para nuestro entero
    subq    $8, %rsp        # Alineamos la pila a 16 bytes

    # ---------------------------------------------------------
    # 2. RECUPERAR EL DOUBLE DE LA PILA Y CASTEALO
    # ---------------------------------------------------------
    movsd   16(%rbp), %xmm0  # Traemos el DOUBLE desde la PILA a %xmm0
    cvttsd2si %xmm0, %rbx    # Casteamos el double a entero en %rbx

    # ---------------------------------------------------------
    # 3. IMPRIMIR EL DOUBLE ORIGINAL
    # ---------------------------------------------------------
    leaq    fmt_double(%rip), %rdi 
    movq    $1, %rax              
    call    printf@PLT            

    # ---------------------------------------------------------
    # 4. IMPRIMIR EL ENTERO CASTEADO
    # ---------------------------------------------------------
    leaq    fmt_int(%rip), %rdi   
    movq    %rbx, %rsi            
    xorq    %rax, %rax            
    call    printf@PLT

    # ---------------------------------------------------------
    # 5. SUMAR +1 AL RESULTADO Y MOSTRARLO
    # ---------------------------------------------------------
    incq    %rbx                  
    
    leaq    fmt_result(%rip), %rdi 
    movq    %rbx, %rsi             
    xorq    %rax, %rax             
    call    printf@PLT

    # ---------------------------------------------------------
    # 6. PREPARAR EL RETORNO Y EPÍLOGO
    # ---------------------------------------------------------
    movq    %rbx, %rax      # ¡NUEVO! Movemos el resultado final a %rax para retornarlo a C
    
    addq    $8, %rsp        
    popq    %rbx            
    popq    %rbp            
    ret