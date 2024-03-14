;MACROS
LimpiarConsola MACRO
    MOV AX, 03h
    INT 10h
ENDM

ImprimirCadenas MACRO registroPrint
    MOV AH, 09h
    LEA DX, registroPrint
    INT 21h
ENDM

ObtenerOpcion MACRO regOpcion
    MOV AH, 01h
    INT 21h
    MOV regOpcion, AL
ENDM

ImprimirTableroJuego MACRO
    LOCAL fila, columna

    MOV BX, 0 ; Indice del indicador de filas -> Inicia en 0
    XOR SI, SI ; Indice para el tablero -> Inicia en 0

    ImprimirCadenas indicadorColumnas
    MOV CL, 0 ; Contador de columnas

    fila:
        ImprimirCadenas salto
        MOV AH, 02h ; Codigo Interrupcion para imprimir un caracter
        MOV DL, indicadorFilas[BX] ; Caracter a imprimir
        INT 21h ; Llamar Interrupcion

        MOV DL, 32 ; Caracter del espacio en blanco
        INT 21h

        columna:
            MOV DL, tablero[SI] ; Caracter del tablero
            INT 21h

            MOV DL, 124 ; Caracter |
            INT 21h

            INC CL ; Incrementamos CL en 1 -> CL++
            INC SI ; Incrementamos SI en 1 -> SI++

            CMP CL, 8 ; Si no ha pasado por las 8 columnas que regrese a la etiqueta 'columna'
            JB columna ; Salto a columna

            MOV CL, 0 ; Reiniciar Contador de columnas
            INC BX ; Incrementar indice indicador de filas -> BX++
            
            CMP BX, 8 ; Si no ha pasado por todas las filas que regrese a la etiqueta 'fila'
            JB fila
ENDM

LlenarTablero MACRO
    LOCAL llenarPeon1, llenarPeon2, Piezas1, Piezas2

    MOV SI, 0 ; Indice del tablero
    MOV CH, 0 ; Contador de peones

    Piezas1:
        MOV DX, 116 ; Caracter a guardar en el tablero
        MOV tablero[SI], DL ; Escribir caracter en el tablero
        PUSH DX ; Guardamos el registro en la pila
        INC SI ; Incrementamos indice de tablero -> SI++

        MOV DX, 99
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 97
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 114
        MOV tablero[SI], DL
        INC SI

        MOV DX, 35
        MOV tablero[SI], DL
        INC SI

        POP DX ; Extraemos registro de la pila y lo almacenamos en DX
        MOV tablero[SI], DL ; Escribimos caracter en el tablero
        INC SI ; Incrementamos indice de tablero -> SI++

        POP DX
        MOV tablero[SI], DL
        INC SI

        POP DX
        MOV tablero[SI], DL
        INC SI
    
    llenarPeon1:
        MOV tablero[SI], 112 ; Escribir caracter en tablero
        INC SI ; Incrementamos indice del tablero
        INC CH ; Incrementamos contador de peones

        CMP CH, 8 ; Si es menor a 8 que regrese a la etiqueta 'llenarPeon1', caso contrario continua
        JB llenarPeon1

        MOV CH, 0
        MOV SI, 48

    llenarPeon2:
        MOV tablero[SI], 80
        INC SI
        INC CH

        CMP CH, 8
        JB llenarPeon2

    Piezas2:
        MOV DX, 84
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 67
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 65
        MOV tablero[SI], DL
        PUSH DX
        INC SI

        MOV DX, 82
        MOV tablero[SI], DL
        INC SI

        MOV DX, 42
        MOV tablero[SI], DL
        INC SI

        POP DX
        MOV tablero[SI], DL
        INC SI

        POP DX
        MOV tablero[SI], DL
        INC SI

        POP DX
        MOV tablero[SI], DL
        INC SI
ENDM
.MODEL small
.STACK 64h

.DATA
    salto db 10,13,"$"
    ;Las cadenas van en el segmento de data
    ;Al final de las cadenas colocar $ para indicar el final
    ; Mensaje informativo inicial
    msj_ini   db 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 10, 13
              db 'FACULTAD DE INGENIERIA', 10, 13
              db 'ESCUELA DE CIENCIAS Y SISTEMAS', 10, 13
              db 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 10, 13
              db 'SECCION A', 10, 13
              db 'Primer semestre 2024', 10, 13
              db 'Josue Alejandro Perez Benito', 10, 13
              db '201712602', 10, 13
              db 'Practica 3', 10, 13 ,'$'
    ; Menu de opciones
    msj_menu  db 10,'MENU:', 10, 13
              db '1. NUEVO JUEGO', 10, 13
              db '2. PUNTAJES', 10, 13
              db '3. REPORTES', 10, 13
              db '4. SALIR', 10, 13
              db 'Seleccione una opcion: $', 10, 13
    ; Tablero
    opcion db 1 dup(32)
    indicadorColumnas db " A B C D E F G H", "$"
    indicadorFilas db "12345678", "$"
    tablero db 64 dup(64);ROW-MAYOR O COLUMN-MAJOR

.CODE
    MOV AX, @data
    MOV DS, AX
    ;Metodo principal (Main)
    Main PROC
        LimpiarConsola
        ImprimirCadenas msj_ini
        
        Menu:
            ImprimirCadenas msj_menu
            ObtenerOpcion opcion ;Obtener la opcion que elige el usuario
            LimpiarConsola
            CMP opcion, 49;Estimulando el registro de banderas 49=1 ASCII
            JE ImprimirTablero
            CMP opcion, 50;Estimulando el registro de banderas 50=2 ASCII
            JE ImprimirPuntajes
            CMP opcion, 51;Estimulando el registro de banderas 51=3 ASCII
            JE ImprimirReportes
            CMP opcion, 52;Estimulando el registro de banderas 52=4 ASCII
            JE Salir

        ImprimirTablero:
            LlenarTablero
            ImprimirTableroJuego
        
        ImprimirPuntajes:

        ImprimirReportes:

            JMP Menu
        Salir:
            MOV AX, 4C00h ;Interrupcion para terminar el programa
            INT 21h
    Main ENDP

END