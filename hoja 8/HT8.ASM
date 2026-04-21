.MODEL SMALL
.STACK 100h
.DATA
    num1 DW ?
    num2 DW ?
    resultado DW 0
    divisor DW 0
    suma1 DW 0
    suma2 DW 0
	cnum1 DB 0
	cnum2 DB 0
	dnum1 DB 0
	dnum2 DB 0
	unum1 DB 0
	unum2 DB 0

    msg1  DB 13,10,'Ingrese el primer numero (3 digitos): $'
    msg2  DB 13,10,'Ingrese el segundo numero (3 digitos): $'
    msgOK DB 13,10,'Son amigos $'
    msgNO DB 13,10,'No son amigos $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

; ---------------------------
; LEER PRIMER NUMERO
; ---------------------------
    MOV AH, 09H
    LEA DX, msg1
    INT 21H

    ; centenas
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV cnum1, AL
	
    ; decenas
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV dnum1, AL

    ; unidades
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV unum1, AL

    ; calcular numero
    XOR AX, AX
	XOR BX, BX
	XOR CX, CX
	XOR DX, DX
	
    MOV AL, cnum1
    MOV BX, 100
    MUL BX
    MOV num1, AX

    XOR AX, AX
    MOV AL, dnum1
    MOV BX, 10
    MUL BX
    ADD num1, AX

	MOV CL, unum1
    XOR CH, CH
    ADD num1, CX

    ; consumir ENTER
    MOV AH, 01H
    INT 21H
	
	;SALTO DE LINEA
	MOV DL, 13
	MOV AH, 2
	INT 21H
	
	CALL IMPRESION1

; ---------------------------
; LEER SEGUNDO NUMERO
; ---------------------------
    MOV AH, 09H
    LEA DX, msg2
    INT 21H

    ; centenas
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV cnum2, AL
	
    ; decenas
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV dnum2, AL

    ; unidades
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV unum2, AL

    ; calcular numero
    XOR AX, AX
	XOR BX, BX
	XOR CX, CX
	XOR DX, DX
	
    MOV AL, cnum2
    MOV BX, 100
    MUL BX
    MOV num2, AX

    XOR AX, AX
    MOV AL, dnum2
    MOV BX, 10
    MUL BX
    ADD num2, AX

	MOV CL, unum2
    XOR CH, CH
    ADD num2, CX

    ; consumir ENTER
    MOV AH, 01H
    INT 21H
	
	;SALTO DE LINEA
	MOV DL, 13
	MOV AH, 2
	INT 21H
	
	CALL IMPRESION2

    MOV resultado, 0
    MOV divisor, 1

CICLO1:
    MOV AX, num1
    XOR DX, DX
    DIV divisor

    CMP DX, 0
    JNE NO_FACTOR1

    MOV AX, divisor
    CMP AX, num1
    JE NO_FACTOR1

    MOV AX, resultado
    ADD AX, divisor
    MOV resultado, AX

NO_FACTOR1:
    INC divisor
    MOV AX, divisor
    CMP AX, num1
    JL CICLO1

    MOV AX, resultado
    MOV suma1, AX

; ---------------------------
; SUMA DIVISORES PROPIOS DE num2
; ---------------------------
    MOV resultado, 0
    MOV divisor, 1

CICLO2:
    MOV AX, num2
    XOR DX, DX
    DIV divisor

    CMP DX, 0
    JNE NO_FACTOR2

    MOV AX, divisor
    CMP AX, num2
    JE NO_FACTOR2

    MOV AX, resultado
    ADD AX, divisor
    MOV resultado, AX
	;CALL IMPRESION

NO_FACTOR2:
    INC divisor
    MOV AX, divisor
    CMP AX, num2
    JL CICLO2

    MOV AX, resultado
    MOV suma2, AX

; ---------------------------
; COMPARAR
; ---------------------------
    MOV AX, suma1
    CMP AX, num2
    JNE NO_AMIGOS

    MOV AX, suma2
    CMP AX, num1
    JNE NO_AMIGOS

    JMP SON_AMIGOS

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

IMPRESION PROC NEAR

    MOV AX, resultado
    
    MOV BL, 100
    DIV BL              ; AX / 100

    MOV CH, AL          ; centenas
    MOV AL, AH          ; resto

    MOV AH, 0
    MOV BL, 10
    DIV BL              ; (resto) / 10

    MOV CL, AL          ; decenas
    MOV DL, AH          ; unidades

; -------- IMPRIMIR --------

    ; centenas
    MOV AL, CH
    ADD AL, 30H
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; decenas
    MOV AL, CL
    ADD AL, 30H
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; unidades
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

RET
IMPRESION ENDP

IMPRESION1 PROC NEAR

	XOR AX, AX
    MOV AX, num1
    
    MOV BL, 100
    DIV BL              ; AX / 100

    MOV CH, AL          ; centenas
    MOV AL, AH          ; resto

    MOV AH, 0
    MOV BL, 10
    DIV BL              ; (resto) / 10

    MOV CL, AL          ; decenas
    MOV BL, AH          ; unidades

; -------- IMPRIMIR --------

    ; centenas
    ADD CH, 30H
    MOV DL, CH
    MOV AH, 02H
    INT 21H

    ; decenas
    ADD CL, 30H
    MOV DL, CL
    MOV AH, 02H
    INT 21H

    ; unidades
	MOV DL, BL
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

RET
IMPRESION1 ENDP

IMPRESION2 PROC NEAR

	XOR AX, AX
    MOV AX, num2
    
    MOV BL, 100
    DIV BL              ; AX / 100

    MOV CH, AL          ; centenas
    MOV AL, AH          ; resto

    MOV AH, 0
    MOV BL, 10
    DIV BL              ; (resto) / 10

    MOV CL, AL          ; decenas
    MOV BL, AH          ; unidades

; -------- IMPRIMIR --------

    ; centenas
    ADD CH, 30H
    MOV DL, CH
    MOV AH, 02H
    INT 21H

    ; decenas
    ADD CL, 30H
    MOV DL, CL
    MOV AH, 02H
    INT 21H

    ; unidades
	MOV DL, BL
    ADD DL, 30H
    MOV AH, 02H
    INT 21H

RET
IMPRESION2 ENDP
MAIN ENDP
END MAIN