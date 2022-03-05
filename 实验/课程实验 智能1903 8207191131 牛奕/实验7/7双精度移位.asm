assume cs:cseg,ds:data
data segment
    db 'welcome to masm!'
data ends
cseg segment
start:mov ax,1234h
      mov ds,ax
	  mov bx,0005h
	  
	  mov ax,71D2H
	  mov bx,5DF1H
	  mov cx,2
	  
l1:	  sar bx,1
	  sar ax,cl
	  loop l1
	  
	  mov ax,5DF1H
	  mov bx,71D2H 
	  mov cx,4
l2:   sar bx,1
	  sar ax,cl
	  loop l2
     
     
      mov ax,4c00H
      INT 21H
cseg ends

end start
