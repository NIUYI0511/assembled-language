assume cs:cseg,ds:data
data segment
    db 'welcome to masm!'
data ends
cseg segment
start:mov ax,1234h
      mov ds,ax
	  mov bx,0005h
	  
	  mov ax,100H
	  mov bx,100H
      div bx  
	  
      mov ax,4c00H
      INT 21H
cseg ends

end start