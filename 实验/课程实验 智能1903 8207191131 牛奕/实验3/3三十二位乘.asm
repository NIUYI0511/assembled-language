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
      mov [xy+2],dx     ;��������λ4�ַ�x1�ͳ�����λ4�ַ�y1��˽����λ����xy,��λ����xy+2

      mov ax,x2
      mov dx,y1
      mul dx
      add [xy+2],ax
      adc [xy+4],dx      ; ��������λ4�ַ�x2�ͳ�����λ4�ַ�y1��˽����λ����xy+2,��λ����xy+4

      mov ax,x1
      mov dx,y2
      mul dx
      add [xy+2],ax
      adc [xy+4],dx
      adc [xy+6],0       ; ��������λ4���ַ�x1�ͳ�����λ4���ַ�y2��˽����λ����xy+2,��λ����xy+4

      mov ax,x2
      mov dx,y2
      mul dx
      add [xy+4],ax
      adc [xy+6],dx      ; ��������λ4���ַ�x2�ͳ�����λ4���ַ�y2��˽����λ����xy+4,��λ����xy+6

      mov ah,4ch
      int 21h

ccode ends
end start
