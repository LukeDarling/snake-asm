bits 16
org 0x100
section .bss
    new_stack: resw 32
section .data
    stack_it: dw 0
section .text
global main 
main: 
jmp _test


__push:
    mov     dx, [top_of_stack]     ; top of stack is a counter of how many items are on the stack
    lea     ax, [stack]            ; put the address of the beginning of the stack into rax
    mov     [ax + dx * 2], cx    ; calculate the location of where we should insert the value, and insert it
    inc     qword [top_of_stack]    ; we put something on the stack so increment the counter
    ret
 
__pop:
    dec     qword [top_of_stack]    ; we are taking something off the stack so decrement the counter
    mov     cx, [top_of_stack]     ; get the new counter value
    lea     ax, [stack]            ; put the address of the beginning of the stack into rax 
    add     ax, cx
	mov     bx, ax
	add     bx, ax
	mov     ax, [bx]    ; move the item we popped off into the return register
    ret

_push: 
   
	;this should work maybe?
	mov     dx, cx
    mov     cx, [stack_it]
    lea     bx, [new_stack]
    add    bx, cx
    mov     [bx], dx
    add word [stack_it], 2
    ret
	
	
_pop:
    sub     word [stack_it], 2
    lea     ax, [new_stack]
    mov     cx, [stack_it]
	add     ax, cx
    mov     bx, ax
    ret 
	
    putchar:
    mov     ax, bx          ; call interrupt x10 sub interrupt xE
    mov     ah, 0x0E
    mov     cx, 1
    int     0x10
    ret
_test:
mov     cx, 0x15
call     _push
call    _pop
call putchar

mov     cx, 0x11
call     _push
call    _pop
call putchar

mov     cx, 0xFF
call     _push
call    _pop
call putchar
ret
