assume cs:cseg,ds:data
data segment
    db 'welcome to masm!'
data ends
cseg segment
start:mov ax,1234h
      mov ds,ax
	  mov bx,0005h
	  
	  mov ax,0
	  mov dx,100H
	  mov cx,100H

    s:add ax,dx
	  loop s

	  
      mov ax,4c00H
      INT 21H
cseg ends

end start