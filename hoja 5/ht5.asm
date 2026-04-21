.MODEL SMALL
.STACK 100H

.DATA
    ; Mensajes
    msg1    DB 13,10,'=== LABORATORIO #5 ===',13,10,'$'

    ; Ejercicio 1
    e1a     DB 13,10,'Ejercicio 1',13,10,'Ingrese el primer numero de un digito: $'
    e1b     DB 13,10,'Ingrese el segundo numero de un digito: $'
    igual   DB 13,10,'Los numeros son iguales.$'
    may1    DB 13,10,'El primero es mayor al segundo.$'
    may2    DB 13,10,'El segundo es mayor al primero.$'

    ; Ejercicio 2
    e2a     DB 13,10,13,10,'Ejercicio 2',13,10,'Ingrese un numero de dos digitos: $'
    mult3   DB 13,10,'El numero ES multiplo de 3.$'
    nomult3 DB 13,10,'El numero NO es multiplo de 3.$'

    ; Ejercicio 3
    e3a     DB 13,10,13,10,'Ejercicio 3',13,10,'Ingrese un solo caracter: $'
    esnum   DB 13,10,'El caracter es un numero.$'
    esletra DB 13,10,'El caracter es una letra.$'
    especial DB 13,10,'El caracter es un caracter especial.$'

    salir   DB 13,10,13,10,'Presione cualquier tecla para finalizar...$'

    ; Variables
    num1    DB ?
    num2    DB ?
    decena  DB ?
    unidad  DB ?
    numero  DB ?
    car     DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Titulo
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    ; =========================
    ; EJERCICIO 1
    ; =========================
    LEA DX, e1a
    MOV AH, 09H
    INT 21H

    ; Leer primer digito
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV num1, AL

    LEA DX, e1b
    MOV AH, 09H
    INT 21H

    ; Leer segundo digito
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV num2, AL

    ; Comparar
    MOV AL, num1
    CMP AL, num2
    JE SON_IGUALES
    JA PRIMERO_MAYOR
    JB SEGUNDO_MAYOR

SON_IGUALES:
    LEA DX, igual
    MOV AH, 09H
    INT 21H
    JMP EJERCICIO2

PRIMERO_MAYOR:
    LEA DX, may1
    MOV AH, 09H
    INT 21H
    JMP EJERCICIO2

SEGUNDO_MAYOR:
    LEA DX, may2
    MOV AH, 09H
    INT 21H

    ; =========================
    ; EJERCICIO 2
    ; =========================
EJERCICIO2:
    LEA DX, e2a
    MOV AH, 09H
    INT 21H

    ; Leer decena
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV decena, AL

    ; Leer unidad
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV unidad, AL

    ; numero = decena*10 + unidad
    MOV AL, decena
    MOV BL, 10
    MUL BL          ; AX = AL * BL
    ADD AL, unidad
    MOV numero, AL

    ; Verificar múltiplo de 3
    ; Si residuo = 0, es múltiplo
    MOV AL, numero
    MOV AH, 0
    MOV BL, 3
    DIV BL          ; AL = cociente, AH = residuo
    CMP AH, 0
    JE ES_MULTIPLO

    LEA DX, nomult3
    MOV AH, 09H
    INT 21H
    JMP EJERCICIO3

ES_MULTIPLO:
    LEA DX, mult3
    MOV AH, 09H
    INT 21H

    ; =========================
    ; EJERCICIO 3
    ; =========================
EJERCICIO3:
    LEA DX, e3a
    MOV AH, 09H
    INT 21H

    ; Leer caracter
    MOV AH, 01H
    INT 21H
    MOV car, AL

    ; ¿Es numero?
    CMP AL, '0'
    JB VER_LETRA
    CMP AL, '9'
    JBE MOSTRAR_NUMERO

VER_LETRA:
    ; ¿Es letra mayuscula?
    CMP AL, 'A'
    JB VER_MINUSCULA
    CMP AL, 'Z'
    JBE MOSTRAR_LETRA

VER_MINUSCULA:
    ; ¿Es letra minuscula?
    CMP AL, 'a'
    JB MOSTRAR_ESPECIAL
    CMP AL, 'z'
    JBE MOSTRAR_LETRA

MOSTRAR_NUMERO:
    LEA DX, esnum
    MOV AH, 09H
    INT 21H
    JMP FIN

MOSTRAR_LETRA:
    LEA DX, esletra
    MOV AH, 09H
    INT 21H
    JMP FIN

MOSTRAR_ESPECIAL:
    LEA DX, especial
    MOV AH, 09H
    INT 21H

FIN:
    LEA DX, salir
    MOV AH, 09H
    INT 21H

    ; Esperar una tecla
    MOV AH, 01H
    INT 21H

    ; Salir a DOS
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN