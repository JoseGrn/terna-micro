.MODEL SMALL
.STACK 100h

.DATA
    mensaje     DB 'Ingrese una cadena: $'
    resultado   DB 13,10,'Cadena en mayusculas: $'
	cantidadMsg DB 13,10, 'Cantidad de caracteres: $'
    buffer      DB 100       ; tamaño máximo [0]
                DB ?         ; longitud real [1]
                DB 100 DUP('$') ; espacio para caracteres [2+]

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09h
    LEA DX, mensaje
    INT 21h

    MOV AH, 0Ah
    LEA DX, buffer
    INT 21h

    ; SI = inicio de la cadena ingresada
    LEA SI, buffer + 2
    MOV CL, [buffer+1]   ; longitud de la cadena
    XOR CH, CH           ; limpiar CH

CONVERTIR:
    MOV AL, [SI]

    CMP AL, 'a'
    JB SIGUIENTE
    CMP AL, 'z'
    JA SIGUIENTE

    ; convertir a mayúscula (restar 32)
    SUB AL, 20h
    MOV [SI], AL

SIGUIENTE:
    INC SI
    LOOP CONVERTIR

    ; mostrar resultado
    MOV AH, 09h
    LEA DX, resultado
    INT 21h

    ; imprimir cadena convertida
    LEA SI, buffer + 2
    MOV CL, [buffer+1]
    XOR CH, CH

IMPRIMIR:
    MOV DL, [SI]
    MOV AH, 02h
    INT 21h

    INC SI
    LOOP IMPRIMIR
	
	; mostrar mensaje
	MOV AH, 09H
	LEA DX, cantidadMsg
	INT 21H
	
	;longitud
	MOV AL, [buffer+1]
	
	MOV AH, 0
	MOV BL, 10
	DIV BL
	
	CMP AL, 0
	JE SOLO_UNIDADES
	
	ADD AL, '0'
	MOV DL, AL
	MOV AH, 02H
	INT 21H
	
SOLO_UNIDADES:
	MOV AL, AH
	ADD AL, '0'
	MOV DL, AL
	MOV AH, 02H
	INT 21H
    
    MOV AH, 4Ch
    INT 21h

MAIN ENDP
END MAIN