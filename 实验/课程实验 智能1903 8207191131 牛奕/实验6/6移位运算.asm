assume cs:cseg,ds:data
data segment
    db 'welcome to masm!'
data ends
cseg segment
start:mov ax,1234h
      mov ds,ax
	  mov bx,0005h
	  
	  mov ax,8F1DH
	  sar ax,1
	  sal ax,1
	  mov ax,4c01H
	
      mov ax,8F1DH
	  mov cx,5
	  
	loop1:
      rol ax,1
	  loop loop1

	  mov cx,7

    loop2:
	  sar ax,1
	  loop loop2
	  	  
	  mov ax,4c02H
      mov ax,4c00H
      INT 21H
cseg ends

end start