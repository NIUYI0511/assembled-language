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
		;参考公式X/N=int(H/N)*65536+[rem(H/N)*65536+L]/N
		;可以把该32位/16位的除法视作2个伪16除法,高位(dx)中存的是0
		;首先000Fh/0Ah,得到16位的商,这个商就是高16位结果(为什么?)
		;上一步的余数左移16位后加上低16位构成32位数
		;尝试证明第二步除法不会溢出:
		;rem<=N-1,L<=0FFFFh
		;res = (N-1)|0FFFFh/N = [65535+(N-1)*65536]/N = 65536-1/N
		;1<=N<=FFFFh,所以res<=FFFF(极端情况下也不会溢出)
divdw:push bx;防止寄存器冲突覆盖原有的值
		push ax;低16位进栈
		mov ax,dx;32位/16位
		mov dx,0
		div cx;int(H/N)*65536,商AX,余数DX,商AX就是最终结果的高16位
		mov bx,ax;bx保存高16位商
		pop ax;低16位送入ax中
		push bx
		div cx;[rem(H/N)*65536+L]/N,低16位商AX不用动,余数DX
		mov cx,dx;cx中保存的是余数
		pop dx;dx中是高16位商
		pop bx;恢复寄存器
		ret
		
codesg ends
end start

