DATAS SEGMENT
    ;此处输入数据段代码
    mess1 DB 'Enter keyword:','$'
    mess2 DB 'Enter Sentence:','$'
    mess3 DB 'Match at location:','$'
    mess4 DB 'NOT MATCH.',13,10,'$'		;13,10表示换行
    mess5 DB 'H of the sentence',13,10,'$'
    change DB 13,10,'$'
    stoknin1 label byte
    max1 db 10 	;关键字大小
    act1 db ?	;记录
    stokn1 db 10 dup(?)
    stoknin2 label byte
    max2 db 50  ;字符串大小
    act2 db ?	;记录
    stokn2 db 50 dup(?) 
    
DATAS ENDS

STACKS SEGMENT

STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
    
START:
    MOV AX,DATAS
    MOV DS,AX
    
    LEA DX,mess1
    MOV ah,09
    INT 21h			;输出Enter keyword
    LEA DX,stoknin1
    MOV ah,0ah		;用21号中段的0ah号功能获取关键字
    INT 21h
    
    cmp act1,0
    je exit			;如果为空直接退出程序
a10: 
    ;输入Sentence并判断
    LEA DX,change
    MOV ah,09
    INT 21h			;输出回程，换行
    LEA DX,mess2 
    MOV ah,09
    INT 21h
    				;输出Enter Sentence:
    LEA DX,stoknin2
    MOV ah,0ah
    INT 21h
   		 			;用21号中段的0ah号功能获取句子
    MOV AL,act1
    CBW				;字节转换为字. (把AL中字节的符号扩展到AH中去)
    MOV CX,AX
    				;保存关键字长度到cx
    PUSH CX
    				;cx入栈
    MOV AL,act2
    cmp AL,0
    je a50
    				;保存句子长度到al，若句子为空则跳转显示not match
    SUB AL,act1
    js a50
    				;若句子长度小于关键字长度，则跳转显示not match
    INC AL
    CBW
    LEA BX,stokn2
    				;将句子的首地址放进BX
    MOV DI,0
    MOV SI,0 
a20:
    				;比较，内循环 
    MOV AH,[BX+DI]
    CMP AH,stokn1[SI]
    				;遇见字符不相等就跳转到a30
    jne a30
    INC DI
    INC SI
    DEC CX
    				;没遇到一个相等的字符,cx-1
    				
    CMP CX,0	
    je a40			;当cx为0是说明关键字比较完
    jmp a20			;若cx不为0则比较下一个字符
a30:

	;外循环，BX+1,清空si，di继续内循环比较
	INC BX
	DEC AL
	cmp AL,0
	je a50
	MOV DI,0
	MOV SI,0
	POP CX
	push CX
	jmp a20
a40:

	;match,将bx减去句子的首地址加一得到关键字所在位置，调用二进制转十六进制子函数将位置输出
	SUB BX,offset stokn2
	INC BX
	LEA DX,change
	MOV ah,09
	INT 21h
	LEA DX,mess3
	MOV ah,09
	INT 21h
	CALL btoh
	LEA DX,mess5
	MOV ah,09
	INT 21h
	jmp a10
	
	;二进制转换十六进制
	btoh PROC NEAR
	MOV CH,4
	rotate: MOV CL,4
	ROL BX,CL
	MOV AL,BL
	and AL,0fh
	add AL,30h
	cmp al,3ah
	jl printit
	add al,7h
	printit:
	MOV dl,al
	MOV ah,2
	int 21h
	dec ch
	jnz rotate
	ret
btoh endp
a50: 

	;显示not match
	LEA DX,change
	MOV ah,09
	INT 21h
	LEA DX,mess4
	
	MOV ah,09
	INT 21h
	jmp a10
exit:
	ret
CODES ENDS
    END START


