assume cs:cseg,ds:data
data segment
    infor1 db 'welcome to work1!'
data ends
cseg segment
start:mov dx,offset infor1
      mov ax,1234h
      mov ds,ax
	  mov bx,0005h

;压缩BCD码
;-------------------
;21+71
    mov al,21h
    mov bl,71h
    add al,bl
    daa				;压缩BCD码的调整指令
;12+49
    mov al,12h
    mov bl,49h
    add al,bl
    daa
;65+82
    mov al,65h
    mov bl,82h
    add al,bl
    daa
;46-33
    mov al,46h
    mov bl,33h
    sub al,bl
    das
;74-58
    mov al,74h
    mov bl,58h
    sub al,bl
    das
;43-54
    mov al,43h
    mov bl,54h
    sub al,bl
    das
;非压缩BCD码
;-------------------
;21+71
    mov ax,0201H
    mov bx,0701H
    add ax,bx
    aaa				;非压缩BCD码调节指令
;12+49
    mov ax,0102H
    mov bx,0409H
    add ax,bx
    aaa
;65+82
    mov ax,0605h
    mov bx,0802h
    add ax,bx
    aaa
;46-33
    mov ax,0406h
    mov bx,0303h
    sub ax,bx
    aas
;74-58
    mov ax,0704h
    mov bx,0508h
    sub ax,bx
    aas
;43-54
    mov ax,0403h
    mov bx,0504h
    sub ax,bx
    aas



    mov ax,4c00H
    INT 21H
cseg ends

end start
