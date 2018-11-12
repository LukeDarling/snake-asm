bits 16

org 0x100

SECTION .text
main:
	mov     byte [task_status], 1               ; set main task to active

	lea     di, [task_a]                        ; create task a
	call    spawn_new_task

	lea     di, [task_b]                        ; create task b
	call    spawn_new_task
;START PRINT DEMO_______________________________________________________________________________________________________________	
	push    bp                      ; 16-bit version of prolog
	mov     bp, sp
	
	mov     ah, 0x0
	mov     al, 0x13
	int     0x10                    ; set video to vga mode

	sub     sp, 6                   ; three local stack variables, bp - 2 = row iter, bp - 4 = col iter, bp - 6 = color
	mov     word [bp - 6], 73        ; start at color
	mov     word [bp - 2], 6        ; start row iter at 0
	mov     word [bp - 4], 5        ; start col iter at 0
	;call _draw_block
;.color_row_loop:
;	cmp     word [bp - 2], 13       ; with 15 x 15 blocks, we can fit roughly 13 rows
;	jne     .continue_color_row
	;____________ADDED STUFF________
	;add     word [bp - 2], 2
	;cmp     word [bp - 2], 6
	;jge     .color_row_loop
	;_______________END_____________
;	jmp     .loop_forever_main
;.continue_color_row:
;	mov     word [bp - 4], 0        ; start col iter at 0
;.color_column_loop:
;	cmp     word [bp - 4], 21       ; with 15 x 15 blocks, we can have roughly 21 columns
;	jne     .continue_color_column
	;jmp     .color_column_done
;.continue_color_column:
	mov     ax, [bp - 2]            ; copy row iter
	mov     bx, 15                  ; block height
	imul    bx
	mov     di, ax                  ; row offset
	mov     ax, [bp - 4]            ; copy col iter

	imul    bx
	mov     si, ax                  ; column offset

	mov     dx, [bp - 6]            ; current color
	call    _draw_block

	;inc     word [bp - 6]           ; next color
;	inc     word [bp - 4]           ; next column
;	jmp     .color_column_loop
;.color_column_done:
;	inc     word [bp - 2]           ; next row
;	jmp     .color_row_loop

; di - row
; si - column
; dx - color

;_________________________________________________________
.loop_forever_main:                             ; have main print for eternity
	lea     di, [task_main_str]
	call    putstring
	call    yield	; we are done printing, let another task know they can print
	;jmp     .loop_forever_main
	mov     ah, 0x0                 ; wait for user input
	int     0x16
	jmp     .exit
	.exit:


	mov     sp, bp
	pop     bp

	mov     ah, 0x4c
	mov     al, 0
	int     0x21
;______________________________________________________________________________
; di should contain the address of the function to run for a task
spawn_new_task:
	lea     bx, [stack_pointers]                ; get the location of the stack pointers
    add     bx, [current_task]                  ; get the location of the current stack pointer
	mov     [bx], sp                            ; save current stack so we can switch back
	mov     cx, [current_task]                  ; look for a new task 
	add     cx, 2                               ; start searching at the next one though
.sp_loop_for_available_stack:
	cmp     cx, [current_task]                  ; we are done when we get back to the original
	jne     .sp_check_if_available
	jmp     .sp_no_available_stack
.sp_check_if_available:
	lea     bx, [task_status]                   ; get status of this stack
	add     bx, cx                              
	cmp     word [bx], 0
	je      .sp_is_available
	add     cx, 2                               ; next stack to search
    and     cx, 0x2F                            ; make sure stack to search is always less than 64
	jmp     .sp_loop_for_available_stack
.sp_is_available:
	lea     bx, [task_status]                   ; we found a stack, set it to active
	add     bx, cx
	mov     word [bx], 1
	lea     bx, [stack_pointers]                ; switch to the fake stack so we can do stuff with it
	add     bx, cx
	mov     sp, [bx]                            ; swap stacks
	push    di                                  ; push address of function to run
	pusha                                       ; push registers
	pushf                                       ; push flags
	lea     bx, [stack_pointers]                ; update top of this stack
	add     bx, cx
	mov     [bx], sp
.sp_no_available_stack:                         ; restore to original stack
	lea     bx, [stack_pointers]
	add     bx, [current_task]
	mov     sp, [bx]
	ret

yield:
	pusha                                       ; push registers
	pushf                                       ; push flags
	lea     bx, [stack_pointers]                ; save current stack pointer
	add     bx, [current_task]
	mov     [bx], sp
	mov     cx, [current_task]                  ; look for a new task 
	add     cx, 2                               ; start searching at the next one though
.y_check_if_enabled:
	lea     bx, [task_status]
	add     bx, cx
	cmp     word [bx], 1
	je      .y_task_available
	add     cx, 2                               ; next stack to search
    and     cx, 0x2F                            ; make sure stack to search is always less than 64
	jmp     .y_check_if_enabled
.y_task_available:
	mov     bx, cx
	mov     [current_task], bx
	mov     bx, stack_pointers                  ; update stack pointer
	add     bx, [current_task]
	mov     sp, [bx]
	popf
	popa
	ret

task_a:
.loop_forever_1:
	lea     di, [task_a_str]
	call    putstring
	call    yield
	;jmp     .loop_forever_1
	; does not terminate or return

task_b:
.loop_forever_2:
	lea     di, [task_b_str]
	call    putstring
	call    yield
	;jmp     .loop_forever_2
	; does not terminate or return
	
task_c:
.loop_forever_3:
	lea     di, [task_c_str]
	call    putstring
	call    yield
	;jmp     .loop_forever_3
	; does not terminate or return
	
task_d:
.loop_forever_4:
	lea     di, [task_d_str]
	call    putstring
	call    yield
	;jmp     .loop_forever_4
	; does not terminate or return
;______________________________________________________________________________	
	; does not terminate or return

;_________________________________________________________
_draw_block:
	push    bp                      ; 16-bit version of prolog
	mov     bp, sp
	mov     bx, 15                  ; block width
	mov     bx, 15                  ; block height
	sub     sp, 6                   ; three local variables, bp - 2 = row iter, bp - 4 = col iter, bp - 6 = color
	mov     [bp - 6], dx
	mov     ax, 0xA000
	mov     es, ax                  ; need location in memory to write to
	mov     word [bp - 2], 0        ; row iter
.row_loop:
	cmp     word [bp - 2], 15       ; < 15
	jne     .continue_row
	jmp     .done_row
	
	
.continue_row:
	mov     word [bp - 4], 0        ; col iter
.column_loop:
	cmp     word [bp - 4], 15       ; < 15
	jne     .continue_column
	jmp     .column_done
.continue_column:
	mov     ax, di                  ; row
	add     ax, [bp - 2]
	mov     bx, 320                 ; size of row in vga
	imul    bx

	mov     bx, si                  ; col
	add     bx, [bp - 4]
	add     bx, ax

	mov     cx, [bp - 6]            ; color
	mov     [es:bx], cx             ; write to screen

	inc     word [bp - 4]           ; increment col
	jmp     .column_loop
.column_done:
	inc     word [bp - 2]           ; increment row
	jmp     .row_loop
.done_row:
	mov     sp, bp
	pop     bp
	ret
;END PRINT DEMO_______________________________________________________________________________________________________________	
	
	



; takes a char to print in dx
; no return value
putchar:
	mov     ax, dx          ; call interrupt x10 sub interrupt xE
	mov     ah, 0x0E
	mov     cx, 1
	int     0x10
	ret

;takes an address to write to in di
;writes to address until a newline is encountered
;returns nothing
putstring:
	cmp     byte [di], 0        ; see if the current byte is a null terminator
	je     	.done 				; nope keep printing
.continue:
	mov     dl, [di]            ; grab the next character of the string
	mov     dh, 0               ; print it
	call    putchar
	inc     di                  ; move to the next character
	jmp     putstring
.done:
	ret

SECTION .data
	task_main_str: db "I am task MAIN", 13, 10, 0
	task_a_str: db "I am the music task", 13, 10, 0
	task_b_str: db "I am the drawing task", 13, 10, 0
	task_c_str: db "I am the input handling task", 13, 10, 0
	task_d_str: db "I am the random food task", 13, 10, 0
	

	current_task: dw 0 ; must always be a multiple of 2
	stacks: times (256 * 31) db 0 ; 31 fake stacks of size 256 bytes
	task_status: times 32 dw 0 ; 0 means inactive, 1 means active
	stack_pointers: dw 0 ; the first pointer needs to be to the real stack !
					dw stacks + (256 * 1)
					dw stacks + (256 * 2)
					dw stacks + (256 * 3)
					dw stacks + (256 * 4)
					dw stacks + (256 * 5)
					dw stacks + (256 * 6)
					dw stacks + (256 * 7)
					dw stacks + (256 * 8)
					dw stacks + (256 * 9)
					dw stacks + (256 * 10)
					dw stacks + (256 * 11)
					dw stacks + (256 * 12)
					dw stacks + (256 * 13)
					dw stacks + (256 * 14)
					dw stacks + (256 * 15)
					dw stacks + (256 * 16)
					dw stacks + (256 * 17)
					dw stacks + (256 * 18)
					dw stacks + (256 * 19)
					dw stacks + (256 * 20)
					dw stacks + (256 * 21)
					dw stacks + (256 * 22)
					dw stacks + (256 * 23)
					dw stacks + (256 * 24)
					dw stacks + (256 * 25)
					dw stacks + (256 * 26)
					dw stacks + (256 * 27)
					dw stacks + (256 * 28)
					dw stacks + (256 * 29)
					dw stacks + (256 * 30)
					dw stacks + (256 * 31)