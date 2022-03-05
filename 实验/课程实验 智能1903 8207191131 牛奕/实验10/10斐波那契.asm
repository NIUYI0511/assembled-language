assume cs:codesg,ds:datasg1

datasg1 segment
    num dw 8 dup(0)
    ;42417671442657
    extra dw 8 dup(0)
    ans db 32 dup(0)
datasg1 ends

datasg2 segment
    dw 1600 dup(0)
    string db 'please input an int from 1 to 150:$'
datasg2 ends



codesg segment
start:
    mov ax,datasg2
    mov ds,ax
    mov si,0
    mov di,16

    mov word ptr [si],0
    mov word ptr [di],1

    call fib

    mov dx,offset string 
    mov ah,9h
    int 21h
    


    mov bx,10
    mov cx,0
l1: 
    mov ah,01h  ;中断调用,单字符输入
    int 21h     ;输入符号的ASCII代码在AL寄存器中

    cmp al,0dh 
    jz over

    sub al,30h 
    add al,cl
    mov ah,0
    mul bx
    mov cx,ax

    jmp l1

over:
    mov ax,cx
    div bx
    mov cx,16
    mul cx
    mov si,ax

    mov ax,datasg1
    mov es,ax

    
    mov di,0

    mov cx,16
    rep movsb

    call show_answer




    mov ax,4c00h
    int 21h 

fib:
    mov cx,150
    s1:
        call add_128
        add si,16
        add di,16
        loop s1
    
    ret

add_128:                ;128位加法，把结果存放到di+16的相对内存中

    push ax
    push cx
    push si
    push di

    mov cx,8
    sub ax,ax
    s0:
        mov ax,[si]
        adc ax,[di]

        mov [di+16],ax
        
        inc si
        inc si
        inc di
        inc di
        loop s0

    pop di
    pop si
    pop cx
    pop ax

    ret






    call show_answer

    mov ax,4c00h
    int 21h


show_answer:
    mov ax,datasg1

    mov ds,ax
    add ax,1
    mov es,ax



    mov bx,36
    mov byte ptr ans[bx],'$'
    dec bx

l2:
    mov si,14
    mov di,14
    call divlong

    add cl,30h
    mov ans[bx],cl
    dec bx

    mov si,0
    mov cx,[si]
    jcxz ok2

    call clr_ex
    
    jmp l2

ok2:

    mov dx,bx
    add dx,32+1
    mov ah,9
    int 21h 

    ret
    






clr_ex:
    push si
    push cx

    mov si,0
    mov cx,8
    l5:
        mov word ptr extra[si],0
        add si,2
        loop l5
    pop cx
    pop si
    ret


divlong:

    mov cx,7
l3:
    push cx

    mov ax,[si-2]
    mov dx,[si]

    mov cx,10
    call divdw

    add es:[di],dx
    add es:[di-2],ax

    mov [si-2],cx
    mov word ptr [si],0

    sub si,2
    sub di,2

    pop cx
    loop l3

    mov cx,[si]
    push cx

    mov cx,16

    mov si,0
    mov di,0
l4:
    mov al,es:[di]
    mov [si],al
    inc si
    inc di
    loop l4

    pop cx

    ret



divdw:  ;算dxax/cx，商dxax余cx

    push bx
    push ax

    mov ax,dx
    mov dx,0
    div cx          ;此时计算 H/N

    mov bx,ax       ;此时bx存放商，dx存放余数

    pop ax
    div cx
    mov cx,dx
    mov dx,bx

    pop bx
    ret 

codesg ends 
end start


