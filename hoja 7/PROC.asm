.MODEL SMALL
.STACK 100h
.DATA
    num1 DB ?
    num2 DB ?
	num DB ?
	dig1 DB ?
	dig2 DB ?
    resultado DB 0
	contEjer DB 0

	msgt1 DB 'MULTIPLICACION $'
	msgt2 DB 'DIVISION $'
	
    msg1 DB 13,10,'Ingrese el primer numero: $'
    msg2 DB 13,10,'Ingrese el segundo numero: $'
	msg3 DB 13,10,'Ingrese un numero de 2 digitos: $'
    msgR DB 13,10,'Resultado: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
	
	
SET_DATOS:
    	CALL SETEO_DATOS

MULTI:
    CALL DO_MULTI
	
IMPRIME_MULTI:
	CALL IMPRESION
	CALL SETEO_DATOS
	
DIVISION:
    CALL DO_DIVI
	
IMPRIME_DIVI:
	CALL IMPRESION

FACTORES_INICIO:
	CALL DO_FACTOR


	
FIN:
    MOV AH, 4CH
    INT 21H
	
LECTURA PROC NEAR
	MOV AH, 01H
    INT 21H
    SUB AL, 30H
RET 
LECTURA ENDP

IMPRESION PROC NEAR
    ; MOSTRAR TEXTO RESULTADO
    MOV AH, 09H
    LEA DX, msgR
    INT 21H

    ; MOSTRAR RESULTADO
    MOV AL, resultado
    MOV AH, 0
	MOV BL, 10
	DIV BL
	
	MOV BH, AH
	
	ADD AL, 30H
	MOV DL, AL
	MOV AH, 02H
	INT 21H
	
	MOV DL, BH
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	
	INC contEjer
RET
IMPRESION ENDP

SETEO_DATOS PROC NEAR
	; PEDIR PRIMER NUMERO
    MOV AH, 09H
    LEA DX, msg1
    INT 21H
	
	CALL LECTURA
    MOV num1, AL

    ; PEDIR SEGUNDO NUMERO
    MOV AH, 09H
    LEA DX, msg2
    INT 21H

	CALL LECTURA
    MOV num2, AL

    ; resultado = 0
    MOV resultado, 0
RET
SETEO_DATOS ENDP

DO_MULTI PROC NEAR

	MOV AL, num2
    CMP AL, 0
    JZ SALIR_MULTI

    MOV AL, resultado
    ADD AL, num1
    MOV resultado, AL

    DEC num2
    JMP MULTI
SALIR_MULTI:
	RET
DO_MULTI ENDP

DO_DIVI PROC NEAR

	MOV AL, num1
    CMP AL, 0
    JZ SALIR_DIVI

    MOV AL, num1
    SUB AL, num2
    MOV num1, AL

    INC resultado
    JMP DIVISION
SALIR_DIVI:
	RET
DO_DIVI ENDP

DO_FACTOR PROC NEAR
	 ; Mostrar mensaje
    MOV AH, 09h
    LEA DX, msg1
    INT 21h

    ; Leer primer dígito
    MOV AH, 01h
    INT 21h
    SUB AL, 30h
    MOV dig1, AL

    ; Leer segundo dígito
    MOV AH, 01h
    INT 21h
    SUB AL, 30h
    MOV dig2, AL

    ; Convertir a número (dig1*10 + dig2)
    MOV AL, dig1
    MOV BL, 10
    MUL BL
    ADD AL, dig2
    MOV num, AL

    ; Salto de línea
    MOV AH, 09h
    LEA DX, msg2
    INT 21h

    ; Inicializar divisor en 1
    MOV CL, 1
	
FACTORES:
    MOV AL, num
    MOV AH, 0
    DIV CL

    CMP AH, 0
    JNE NO_FACTOR

    ; Imprimir factor
    MOV resultado, CL
    JMP IMPRESION_FACTORES

CONTINUA_FACTOR:
    MOV DL, ' '
    INT 21h

NO_FACTOR:
    INC CL
    CMP CL, num
    JBE FACTORES

    ; salir
    JMP SALIR_FACTOR

IMPRESION_FACTORES:

    ; MOSTRAR RESULTADO
    MOV AL, resultado
    MOV AH, 0
	MOV BL, 10
	DIV BL
	
	MOV BH, AH
	
	ADD AL, 30H
	MOV DL, AL
	MOV AH, 02H
	INT 21H
	
	MOV DL, BH
	ADD DL, 30H
	MOV AH, 02H
	INT 21H
	
	INC contEjer
	
	JMP CONTINUA_FACTOR
	
SALIR_FACTOR:
	RET
DO_FACTOR ENDP

MAIN ENDP
END MAIN