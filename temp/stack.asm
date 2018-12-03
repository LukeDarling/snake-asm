bits 16
org 0x100
section .bss
    new_stack: resw 100
section .data
    stack_it: dw 0
section .text
global main 
main: 
jmp _test
_push: 
    mov     dx, cx
    mov     cx, [stack_it]
    lea     ax, [new_stack]
    mov     [ax + cx * 2], dx
    inc     word [stack_it]
    ret
	
	;this should work maybe?
	mov     dx, cx
    mov     cx, [stack_it]
    lea     bx, [new_stack]
    add    bx, cx
    mov     [bx], dx
    add [stack_it], 2
    ret
	
	
_pop:
    dec     word [stack_it]
    lea     ax, [new_stack]
    mov     cx, [stack_it]
    mov     dx, [ax + cx * 2]
    ret 
    putchar:
    mov     ax, dx          ; call interrupt x10 sub interrupt xE
    mov     ah, 0x0E
    mov     cx, 1
    int     0x10
    ret
_test:
mov     cx, 0x10
call     _push
call    _pop
call putchar
ret
