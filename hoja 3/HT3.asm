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

	MOV AL, contEjer
	CMP AL, 2
	JZ FACTORES_INICIO
	MOV AL, contEjer
	CMP AL, 3
	JNZ SEGUIR
	JMP FIN
	
SEGUIR:
    ; PEDIR PRIMER NUMERO
    MOV AH, 09H
    LEA DX, msg1
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV num1, AL

    ; PEDIR SEGUNDO NUMERO
    MOV AH, 09H
    LEA DX, msg2
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV num2, AL

    ; resultado = 0
    MOV resultado, 0
	
	MOV AL, contEjer
	CMP AL, 1
	JZ DIVISION
	

MULTI:
    MOV AL, num2
    CMP AL, 0
    JZ IMPRESION

    MOV AL, resultado
    ADD AL, num1
    MOV resultado, AL

    DEC num2
    JMP MULTI
	
DIVISION:
    MOV AL, num1
    CMP AL, 0
    JZ IMPRESION

    MOV AL, num1
    SUB AL, num2
    MOV num1, AL

    INC resultado
    JMP DIVISION

FACTORES_INICIO:
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
    MOV AH, 4Ch
    INT 21h

IMPRESION:
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
	
	JMP SET_DATOS

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
	
FIN:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN