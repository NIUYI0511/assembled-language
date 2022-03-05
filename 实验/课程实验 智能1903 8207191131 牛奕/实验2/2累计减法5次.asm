assume cs:cseg,ds:data
data segment
    db 'welcome to masm!'
data ends
cseg segment
start:mov ax,1234h
      mov ds,ax
	  mov bx,0005h
	  
	  mov ax,10011000B
	  mov dx,01000000B
	  mov cx,5

    s:sub ax,dx
	  loop s
	  
	  mov ds:[bx],ax
	  
      mov ax,4c00H
      INT 21H
cseg ends

end start