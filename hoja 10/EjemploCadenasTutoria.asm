.model small 					;Modelo - tamanio del programa
.data
	num1 DB 135
	cadena1 DB 'hola$'
	cadena2 DB 'hola$'
	iguales DB 'Son  Iguales$'
	noiguales DB 'No son Iguales$'
	
.stack							;segmento de pila
.code 							;segmento de codigo
programa:						;etiqueta que indica el punto de arranque
		; INICIALIZAR EL PROGRAMA 
		MOV AX, @DATA      		; Asigna al registro AX, la direccion de inicio del segmento de datos
		MOV DS, AX
		
		;MOV AH, 09h
		;LEA DX, cadena1         ; MOV DX, OFFSET cadena1  -> Asignar la posicion de memoria donde empieza la cadena
		; Obtenemos la posicion 0 de la cadena
		; Apuntamos a la posicion 0
		;INT 21h
		
		; SI DI  Data Index, no importa cual se use
		; Punteros oficiales
		LEA SI, cadena1 ; decirle a SI donde inicia la cadena1
		LEA DI, cadena2; Decirle a DI donde inicia la cadena 2
		; INC SI, Add SI, 2 -> Cada caracter que se tenga en la cadena
		comparar:
			MOV DL, [SI]  ; Asignar el valor de la pos0 [0] para imprimir
			;MOV BL, '5'   ; Siempre el final debe ser el signo de $, Se recomienda usar registros como intermediarios para intercambiar valores
			;MOV [SI], BL
			MOV DH, [DI]  ; Asignar para la comparacion
			INC SI
			INC DI
			CMP DL, '$'
			JE comparar2
			CMP DL, DH
			JE comparar
			JNE imprimirnosoniguales
		comparar2:
			CMP DH, '$'
			JE Imprimirsoniguales
			JNE imprimirnosoniguales
			
		imprimirnosoniguales:
			LEA DX, noiguales
			MOV AH, 9h
			INT 21h
			jmp finalizar
		Imprimirsoniguales:
			LEA DX, iguales
			MOV ah, 9h
			INT 21h
		
		finalizar:
		LEA DX, cadena1
		MOV AH, 9h
		INT 21h
		; FINALIZAR EL PROGRAMA
		MOV AH, 4Ch				; interrupcion de finalizar programa
		INT 21h					; llamada a ejecutar la interrupcion anterior
		
END programa