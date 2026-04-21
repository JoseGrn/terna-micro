.model small
.stack 100h

.data
    XVAL dw 12
    YVAL dw 4
    ZVAL dw 3

    msg1  db 13,10,"1) X+Y     = $"
    msg2  db 13,10,"2) X-Z     = $"
    msg3  db 13,10,"3) X*Y     = $"
    msg4  db 13,10,"4) X/Y     = $"
    msg5  db 13,10,"5) X%Y     = $"
    msg6  db 13,10,"6) X*Y-Z   = $"
    msg7  db 13,10,"7) Z-X*Y   = $"
    msg8  db 13,10,"8) X+Z/Y   = $"
    msg9  db 13,10,"9) Z-X/Y   = $"
    msg10 db 13,10,"10) Y+Z/X  = $"

    endl db 13,10,"$"

.code
main proc
    mov ax, @data
    mov ds, ax

    mov bx, XVAL
    mov cx, YVAL
    mov dx, ZVAL

    lea dx, msg1
    call PrintStr
    mov ax, bx
    add ax, cx
    call PrintAX_2DigitsSigned

    lea dx, msg2
    call PrintStr
    mov ax, bx
    sub ax, dx
    call PrintAX_2DigitsSigned

    lea dx, msg3
    call PrintStr
    mov ax, bx
    imul cx
    call PrintAX_2DigitsSigned

    lea dx, msg4
    call PrintStr
    mov ax, bx
    cwd
    idiv cx
    call PrintAX_2DigitsSigned

    lea dx, msg5
    call PrintStr
    mov ax, bx
    cwd
    idiv cx
    mov ax, dx
    call PrintAX_2DigitsSigned

    lea dx, msg6
    call PrintStr
    mov ax, bx
    imul cx
    sub ax, ZVAL
    call PrintAX_2DigitsSigned

    lea dx, msg7
    call PrintStr
    mov ax, bx
    imul cx
    mov si, ax
    mov ax, ZVAL
    sub ax, si
    call PrintAX_2DigitsSigned

    lea dx, msg8
    call PrintStr
    mov ax, ZVAL
    cwd
    idiv cx
    add ax, bx
    call PrintAX_2DigitsSigned

    lea dx, msg9
    call PrintStr
    mov ax, bx
    cwd
    idiv cx
    mov si, ax
    mov ax, ZVAL
    sub ax, si
    call PrintAX_2DigitsSigned

    lea dx, msg10
    call PrintStr
    mov ax, ZVAL
    cwd
    idiv bx
    add ax, cx
    call PrintAX_2DigitsSigned

    lea dx, endl
    call PrintStr

    mov ax, 4C00h
    int 21h
main endp

PrintStr proc
    mov ah, 09h
    int 21h
    ret
PrintStr endp

PrintAX_2DigitsSigned proc
    push ax
    push bx
    push dx

    cmp ax, 0
    jge P_Pos
    mov dl, '-'
    mov ah, 02h
    int 21h
    neg ax
P_Pos:

    mov bx, 10
    xor dx, dx
    div bx

    mov dh, dl

    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    mov dl, dh
    add dl, '0'
    mov ah, 02h
    int 21h

    pop dx
    pop bx
    pop ax
    ret
PrintAX_2DigitsSigned endp

end main