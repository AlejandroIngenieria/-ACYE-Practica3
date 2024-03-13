.model medium
.stack 100h

.data
    ; Mensaje informativo inicial
    mensaje   db 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 0Dh, 0Ah
              db 'FACULTAD DE INGENIERIA', 0Dh, 0Ah
              db 'ESCUELA DE CIENCIAS Y SISTEMAS', 0Dh, 0Ah
              db 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 0Dh, 0Ah
              db 'SECCION A', 0Dh, 0Ah
              db 'Primer semestre 2024', 0Dh, 0Ah
              db 'Josue Alejandro Perez Benito', 0Dh, 0Ah
              db '201712602', 0Dh, 0Ah
              db 'Practica 3', 0Dh, 0Ah, '$'
    ; Menu de opciones
    menuMsg   db 'MENU:', 0Dh, 0Ah
              db '1. NUEVO JUEGO', 0Dh, 0Ah
              db '2. PUNTAJES', 0Dh, 0Ah
              db '3. REPORTES', 0Dh, 0Ah
              db '4. SALIR', 0Dh, 0Ah
              db 'Seleccione una opcion: $', 0Dh, 0Ah
    ; Tablero
    tablero   db 0Ah, '  |  A  |  B  |  C  |  D  |  E  |  F  |  G  |  H  |' ,0Ah
              db '  |-----|-----|-----|-----|-----|-----|-----|-----|',  0Ah
              db '1 |  t  |  c  |  a  |  r  |  *  |  a  |  c  |  t  |',  0Ah
              db '2 |  p  |  p  |  p  |  p  |  p  |  p  |  p  |  p  |',  0Ah
              db '3 |     |     |     |     |     |     |     |     |',  0Ah
              db '4 |     |     |     |     |     |     |     |     |',  0Ah
              db '5 |     |     |     |     |     |     |     |     |',  0Ah
              db '6 |     |     |     |     |     |     |     |     |',  0Ah
              db '7 |  P  |  P  |  P  |  P  |  P  |  P  |  P  |  P  |',  0Ah
              db '8 |  T  |  C  |  A  |  R  |  *  |  A  |  C  |  T  |',  0Ah
              db '  |-----|-----|-----|-----|-----|-----|-----|-----|',  0Ah
              db '  |  A  |  B  |  C  |  D  |  E  |  F  |  G  |  H  |',  0Ah, '$'

    ; Lectura de entradas
    opcion    db ?
    ; Validacion de entradas
    error_msg db 0Dh, 0Ah, 'Opcion no valida. Intente de nuevo.', 0Dh, 0Ah, '$'
    valid_msg db 0Dh, 0Ah, 'Opcion valida.', 0Dh, 0Ah, '$'
    
    msj_vs    db 0Ah,' VS ', 0Ah, '$'
    msj_IA    db ' IA ', 0Ah, '$'

.code
main PROC
                 mov ax, @data
                 mov ds, ax

    ; /* -------------------------------------------------------------------------- */
    ; /*                               MENSAJE INICIAL                              */
    ; /* -------------------------------------------------------------------------- */
                 mov ah, 9
                 mov dx, OFFSET mensaje
                 int 21h
    ; /* -------------------------------------------------------------------------- */
    ; /*                               MENU PRINCIPAL                               */
    ; /* -------------------------------------------------------------------------- */
    menuLoop:    
    ; Imprimir el menú
                 mov ah, 9
                 mov dx, OFFSET menuMsg
                 int 21h

    ; Leer la opción ingresada por el usuario
                 mov ah, 1
                 int 21h

    ; Opciones
                 cmp al, '1'
                 je  new_game
                 cmp al, '2'
                 je  option_valid
                 cmp al, '3'
                 je  option_valid
                 cmp al, '4'
                 je  exit

    ; Si no es válida, mostrar mensaje de error
                 mov ah, 9
                 mov dx, OFFSET error_msg
                 int 21h
    ; Volver al menú
                 jmp menuLoop

    option_valid:
    ; Si la opción es válida, mostrar mensaje de opción válida
                 mov ah, 9
                 mov dx, OFFSET valid_msg
                 int 21h
    ; Salto al menú principal
                 jmp menuLoop
    ;/* -------------------------------------------------------------------------- */
    ;/*                                 NUEVO JUEGO                                */
    ;/* -------------------------------------------------------------------------- */
    new_game:    

    ; Mostrar el mensaje 'VS'
                 mov ah, 9
                 mov dx, OFFSET msj_vs
                 int 21h

    ; Mostrar el mensaje 'IA'
                 mov ah, 9
                 mov dx, OFFSET msj_IA
                 int 21h

    ; Mostrar el tablero
                 mov ah, 9
                 mov dx, OFFSET tablero
                 int 21h

                 jmp menuLoop

    ;/* -------------------------------------------------------------------------- */
    ;/*                                    SALIR                                   */
    ;/* -------------------------------------------------------------------------- */
    exit:        
                 mov ah, 4Ch                  ; Terminar el programa
                 int 21h

main ENDP

END main
