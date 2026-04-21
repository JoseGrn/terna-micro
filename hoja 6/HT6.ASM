.MODEL SMALL
.STACK 100H

.DATA
    titulo      DB 13,10,'=== LABORATORIO 6 ===',13,10,'$'

    ; Ejercicio 1
    msgE1       DB 13,10,'Ejercicio 1: Multiplicacion por sumas sucesivas',13,10,'$'
    msgNum1     DB 'Ingrese el primer numero de un digito: $'
    msgNum2     DB 13,10,'Ingrese el segundo numero de un digito: $'
    msgResMul   DB 13,10,'Resultado de la multiplicacion: $'

    ; Ejercicio 2
    msgE2       DB 13,10,13,10,'Ejercicio 2: Sumatoria desde 1 hasta N',13,10,'$'
    msgN        DB 'Ingrese un numero de un digito: $'
    msgResSum   DB 13,10,'La sumatoria es: $'

    ; Ejercicio 3
    msgE3       DB 13,10,13,10,'Ejercicio 3: Promedio de 4 numeros de un digito',13,10,'$'
    msg4num     DB 'Ingrese un numero: $'
    msgProm     DB 13,10,'El promedio es: $'

    msgFin      DB 13,10,13,10,'Presione cualquier tecla para finalizar...$'

    ; Variables
    n1          DB ?
    n2          DB ?
    resultado   DB ?
    sumaTotal   DB ?
    contador    DB ?
    promedio    DB ?

.CODE

; ---------------------------------------------------
; Procedimiento para imprimir el valor de AL
; Si es de 2 digitos, imprime ambos
; ---------------------------------------------------
IMPRIMIR_NUM PROC
    AAM             ; AL -> decenas en AH, unidades en AL

    CMP AH, 0
    JE SOLO_UNIDAD

    MOV DL, AH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

SOLO_UNIDAD:
    MOV DL, AL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    RET
IMPRIMIR_NUM ENDP

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; TITULO
    ; -------------------------
    LEA DX, titulo
    MOV AH, 09H
    INT 21H

    ; ==================================================
    ; EJERCICIO 1: Multiplicacion por sumas sucesivas
    ; ==================================================
    LEA DX, msgE1
    MOV AH, 09H
    INT 21H

    LEA DX, msgNum1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV n1, AL

    LEA DX, msgNum2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV n2, AL

    ; resultado = 0
    MOV AL, 0
    MOV resultado, AL

    ; contador = n2
    MOV CL, n2
    MOV CH, 0

MULT_LOOP:
    CMP CX, 0
    JE FIN_MULT

    MOV AL, resultado
    ADD AL, n1
    MOV resultado, AL

    LOOP MULT_LOOP

FIN_MULT:
    LEA DX, msgResMul
    MOV AH, 09H
    INT 21H

    MOV AL, resultado
    CALL IMPRIMIR_NUM

    ; ==================================================
    ; EJERCICIO 2: Sumatoria de 1 hasta N con LOOP
    ; ==================================================
    LEA DX, msgE2
    MOV AH, 09H
    INT 21H

    LEA DX, msgN
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV n1, AL

    MOV AL, 0
    MOV sumaTotal, AL

    MOV CL, n1
    MOV CH, 0

SUM_LOOP:
    MOV AL, sumaTotal
    ADD AL, CL
    MOV sumaTotal, AL
    LOOP SUM_LOOP

    LEA DX, msgResSum
    MOV AH, 09H
    INT 21H

    MOV AL, sumaTotal
    CALL IMPRIMIR_NUM

    ; ==================================================
    ; EJERCICIO 3: Promedio de 4 numeros de un digito
    ; ==================================================
    LEA DX, msgE3
    MOV AH, 09H
    INT 21H

    MOV AL, 0
    MOV sumaTotal, AL

    MOV CX, 4

LEER_4:
    LEA DX, msg4num
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'

    MOV BL, AL
    MOV AL, sumaTotal
    ADD AL, BL
    MOV sumaTotal, AL

    ; salto de linea
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    MOV AH, 02H
    INT 21H

    LOOP LEER_4

    ; promedio = sumaTotal / 4
    MOV AL, sumaTotal
    MOV AH, 0
    MOV BL, 4
    DIV BL
    MOV promedio, AL

    LEA DX, msgProm
    MOV AH, 09H
    INT 21H

    MOV AL, promedio
    CALL IMPRIMIR_NUM

    ; -------------------------
    ; FIN
    ; -------------------------
    LEA DX, msgFin
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP

END MAIN