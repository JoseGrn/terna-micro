.MODEL SMALL
.STACK 100h
.DATA
    num1 DW ?
    num2 DW ?
    resultado DW 0
    divisor DW 0

    msg1  DB 13,10,'Ingrese el primer numero (3 digitos): $'
    msg2  DB 13,10,'Ingrese el segundo numero (3 digitos): $'
    msgOK DB 13,10,'Son amigos $'
    msgNO DB 13,10,'No son amigos $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

; ---------------------------
; LEER PRIMER NUMERO (3 DIGITOS)
; ---------------------------
    MOV AH, 09H
    LEA DX, msg1
    INT 21H

    ; Leer centenas
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV BL, AL

    ; Leer decenas
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV BH, AL

    ; Leer unidades
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV CL, AL

    ; Calcular numero = centenas*100 + decenas*10 + unidades
    XOR AX, AX
    MOV AL, BL
    MOV BX, 100
    MUL BX

    MOV DX, AX

    XOR AX, AX
    MOV AL, BH
    MOV BX, 10
    MUL BX

    ADD DX, AX
    XOR CH, CH
    ADD DX, CX

    MOV num1, DX

; ---------------------------
; LEER SEGUNDO NUMERO (3 DIGITOS)
; ---------------------------
    MOV AH, 09H
    LEA DX, msg2
    INT 21H

    ; Leer centenas
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV BL, AL

    ; Leer decenas
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV BH, AL

    ; Leer unidades
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV CL, AL

    ; Calcular numero = centenas*100 + decenas*10 + unidades
    XOR AX, AX
    MOV AL, BL
    MOV BX, 100
    MUL BX

    MOV DX, AX

    XOR AX, AX
    MOV AL, BH
    MOV BX, 10
    MUL BX

    ADD DX, AX
    XOR CH, CH
    ADD DX, CX

    MOV num2, DX

; ---------------------------
; SUMAR DIVISORES PROPIOS DE num1
; ---------------------------
    MOV resultado, 0
    MOV divisor, 1

INICIO:
    MOV AX, num1
    XOR DX, DX
    DIV divisor          ; AX / divisor, residuo en DX

    CMP DX, 0
    JNE NO_FACTOR

    ; no sumar el mismo numero
    MOV AX, divisor
    CMP AX, num1
    JE NO_FACTOR

    MOV AX, resultado
    ADD AX, divisor
    MOV resultado, AX

NO_FACTOR:
    INC divisor
    MOV AX, divisor
    CMP AX, num1
    JB INICIO

; ---------------------------
; COMPARACION
; ---------------------------
COMPARACION:
    MOV AX, resultado
    CMP AX, num2
    JE SON_AMIGOS
    JMP NO_AMIGOS

SON_AMIGOS:
    MOV AH, 09H
    LEA DX, msgOK
    INT 21H
    JMP SALIR

NO_AMIGOS:
    MOV AH, 09H
    LEA DX, msgNO
    INT 21H

SALIR:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN