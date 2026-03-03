.model small
.data
; variables
	; NOMBRE TAMANO VALOR
	cadena DB 'Hola mundo $' ;
	num1 DB 4
.stack
.code
programa: ;no puede ser main, program, 

	MOV AX, @Data
	MOV DS, AX
	
	;imprimir
	;MOV DX, offset cadena
	LEA DX, cadena ;asignar el inicio del arreglo
	MOV AH, 9H ;parametro para imprimir cadena
	INT 21H
	
	;imprimir numero
	MOV DL, num1 ;asignar numero
	MOV AH, 2H
	INT 21H
	
	;finalizar
	MOV AH, 4CH
	INT 21H

end programa