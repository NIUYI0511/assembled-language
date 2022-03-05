assume cs:ccode, ds:ddata
ddata segment
      x1 dw 0F0FH
      x2 dw 0000H
      y1 dw 0FF00H
      y2 dw 0000H
      xy dw 4 dup (?)
ddata ends
ccode segment
start:mov ax,ddata
      mov ds,ax

      mov ax,x1
      mov dx,y1
      mul dx
      mov [xy],ax
      mov [xy+2],dx     ;被乘数低位4字符x1和乘数低位4字符y1相乘结果低位存入xy,高位存入xy+2

      mov ax,x2
      mov dx,y1
      mul dx
      add [xy+2],ax
      adc [xy+4],dx      ; 被乘数高位4字符x2和乘数低位4字符y1相乘结果低位存入xy+2,高位存入xy+4

      mov ax,x1
      mov dx,y2
      mul dx
      add [xy+2],ax
      adc [xy+4],dx
      adc [xy+6],0       ; 被乘数低位4个字符x1和乘数高位4个字符y2相乘结果低位存入xy+2,高位存入xy+4

      mov ax,x2
      mov dx,y2
      mul dx
      add [xy+4],ax
      adc [xy+6],dx      ; 被乘数高位4个字符x2和乘数高位4个字符y2相乘结果低位存入xy+4,高位存入xy+6

      mov ah,4ch
      int 21h

ccode ends
end start
