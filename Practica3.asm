.model small
.stack 100h

.data
    mensaje db 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 0Dh, 0Ah
            db 'FACULTAD DE INGENIERIA', 0Dh, 0Ah
            db 'ESCUELA DE CIENCIAS Y SISTEMAS', 0Dh, 0Ah
            db 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 0Dh, 0Ah
            db 'SECCION A', 0Dh, 0Ah
            db 'Primer semestre 2024', 0Dh, 0Ah
            db 'Josue Alejandro Perez Benito', 0Dh, 0Ah
            db '201712602', 0Dh, 0Ah
            db 'Práctica 3', 0Dh, 0Ah, '$'
    menuMsg db 'MENU:', 0Dh, 0Ah
            db '1. NUEVO JUEGO', 0Dh, 0Ah
            db '2. PUNTAJES', 0Dh, 0Ah
            db '3. REPORTES', 0Dh, 0Ah
            db '4. SALIR', 0Dh, 0Ah
            db 'Seleccione una opcion: $'
    opcion db ?
    error_msg db 'Opcion no valida. Intente de nuevo.', 0Dh, 0Ah, '$'
    valid_msg db 'Opcion valida.', 0Dh, 0Ah, '$'

.code
main PROC
    mov ax, @data
    mov ds, ax
    
    ; Imprimir el mensaje inicial
    mov ah, 9
    mov dx, OFFSET mensaje
    int 21h
    
    ; Bucle del menú
menuLoop:
    ; Imprimir el menú
    mov ah, 9
    mov dx, OFFSET menuMsg
    int 21h
    
    ; Leer la opción ingresada por el usuario
    mov ah, 1
    int 21h
    
    ; Verificar si la opción es válida (1-4)
    cmp al, '1'
    je option_valid
    cmp al, '2'
    je option_valid
    cmp al, '3'
    je option_valid
    cmp al, '4'
    je option_valid
    
    ; Si no es válida, mostrar mensaje de error
    mov ah, 9
    mov dx, OFFSET error_msg
    int 21h
    jmp menuLoop  ; Volver al menú
    
option_valid:
    ; Si la opción es válida, mostrar mensaje de opción válida
    mov ah, 9
    mov dx, OFFSET valid_msg
    int 21h
    
    ; Si la opción es "Salir", terminar el programa
    cmp al, '4'
    je exit
    
    jmp menuLoop  ; Volver al menú

exit:
    mov ah, 4Ch     ; Terminar el programa
    int 21h
main ENDP

END main
