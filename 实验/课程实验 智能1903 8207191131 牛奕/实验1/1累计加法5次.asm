assume cs:cseg,ds:data
data segment
    infor1 db 'welcome to work1!'
data ends
cseg segment
start:mov dx,offset infor1
      mov ax,1234h
      mov ds,ax
	  mov bx,0005h
	  
	  mov ax,0
	  mov dx,1
	  mov cx,5

    s:add ax,dx
	  inc dx
	  loop s
	  
	  mov ds:[bx],ax
      mov ax,4c00H
      INT 21H
cseg ends

end start