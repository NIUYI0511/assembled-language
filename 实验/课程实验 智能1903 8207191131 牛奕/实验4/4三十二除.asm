assume ds:datasg,ss:stacksg,cs:codesg
datasg segment

datasg ends
stacksg segment
dw 0,0,0,0,0,0,0,0
stacksg ends
codesg segment
start:mov ax,stacksg
		mov ss,ax
		mov sp,16
		mov ax,0000h
		mov dx,0F0Fh
		mov cx,0FF00h
		call divdw
		
		mov ax,4c00h
		int 21h
		;�ο���ʽX/N=int(H/N)*65536+[rem(H/N)*65536+L]/N
		;���԰Ѹ�32λ/16λ�ĳ�������2��α16����,��λ(dx)�д����0
		;����000Fh/0Ah,�õ�16λ����,����̾��Ǹ�16λ���(Ϊʲô?)
		;��һ������������16λ����ϵ�16λ����32λ��
		;����֤���ڶ��������������:
		;rem<=N-1,L<=0FFFFh
		;res = (N-1)|0FFFFh/N = [65535+(N-1)*65536]/N = 65536-1/N
		;1<=N<=FFFFh,����res<=FFFF(���������Ҳ�������)
divdw:push bx;��ֹ�Ĵ�����ͻ����ԭ�е�ֵ
		push ax;��16λ��ջ
		mov ax,dx;32λ/16λ
		mov dx,0
		div cx;int(H/N)*65536,��AX,����DX,��AX�������ս���ĸ�16λ
		mov bx,ax;bx�����16λ��
		pop ax;��16λ����ax��
		push bx
		div cx;[rem(H/N)*65536+L]/N,��16λ��AX���ö�,����DX
		mov cx,dx;cx�б����������
		pop dx;dx���Ǹ�16λ��
		pop bx;�ָ��Ĵ���
		ret
		
codesg ends
end start

