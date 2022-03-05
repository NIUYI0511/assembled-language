assume cs:cseg,ds:data
data segment
    infor1 db 'welcome to work1!'
data ends
cseg segment
start:mov dx,offset infor1
      mov ax,1234h
      mov ds,ax
	  mov bx,0005h
	  
	  mov ax,0FH
	  mov dx,01H
	  add ax,dx	  
	  mov ds:[bx],ax
	  mov ax,4c01H
	  
	  mov ax,0FFH
	  mov dx,01H
	  add ax,dx	  
	  mov ds:[bx],ax
	  mov ax,4c02H
	  
	  mov ax,0FFFH
	  mov dx,01H
	  add ax,dx	  
	  mov ds:[bx],ax
	  mov ax,4c03H
	  
	  mov ax,0FFFFH
	  mov dx,01H
	  add ax,dx	  
	  mov ds:[bx],ax
	  mov ax,4c04H
	  
	  mov ax,0FFFFH
	  mov bx,0FFFFH
      add bx,0001H
	  adc ax,0000H
	  mov ax,4c05H
	  

	  
      mov ax,4c00H
      INT 21H
cseg ends

end start
