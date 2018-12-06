	;inc     word [score]
	;mov     ax, [score]
	;call    printHexChar


bits 16
org 0x100

SECTION .text
main:
	mov     ah, 0x0
	mov     al, 0x1
	int     0x10                    ; set video to text mode
	mov dx, 0
	mov ax, 0
.mainloop:
	cmp dx, 0xFFE
	jge .done
	inc dx
	
	inc     word [score]
	mov     ax, [score]
	call    printHexChar
	
	mov     ah, 0x0                 ; wait for user input
	int     0x16
		
	jmp .mainloop
.done:	
	mov     ah, 0x0                 ; wait for user input
	int     0x16
	
	mov     ah, 0x4c                ; exit
	mov     al, 0
	int     0x21
	
printHexChar:
pusha
push si
	mov cx, 0
	
.printhexloop:
	cmp cx, 7
	jg .endprinthex
	rol ax, 4
	mov bx, ax
	and bx, 0xF
	
	mov     dx, 0xB800
	mov     es, dx               
	
	mov si, [digits + bx]
	
	mov     ax, 0x1F00
	and     cx, 0x00FF
	;and     ax, 0x00FF 
	and     cx, ax
	mov     bx, cx
	
	
	
	;mov     bx, 0               
	;or      si, 0x1F00
	;and     cx, ax
	;add bx, cx
	
	mov     word [es:bx], si  

	add cx, 2
	jmp .printhexloop
.endprinthex:
pop si	
popa
ret

section	.data
digits		db	"0123456789abcdef"
score		dw	0
ivt8_offset	dw	0
ivt8_segment	dw	0
msg_finish	db	"Enter an empty string to quit...", 10, 13, 10, 13, 0
msg_prompt	db	"What is your name? ", 0
msg_hello	db	"Why, hello, ", 0
msg_bangbang	db	"!!", 10, 13, 0
input_buff	times 32 db 0
