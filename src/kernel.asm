; Snake-ASM
; A classic Snake game written in Assembly.
; Written by Amy Surrett, Jonathan DeGirolano, and Luke Darling.

bits 16

org 0

SECTION	.text

main:



	.main:

	mov	ax, cs
	mov	ds, ax

	mov	ax, 0x0000
	mov	es, ax
	; ; Hook into interrupt 8 to create a timer
	cli
	mov 	bx, [es:IVT8_OFFSET_SLOT]
	mov 	[ivt8_offset], bx
	mov 	bx, [es:IVT8_SEGMENT_SLOT]
	mov 	[ivt8_segment], bx
	mov 	bx, timerHandler
	mov 	[es:IVT8_OFFSET_SLOT], bx
	mov 	bx, cs
	mov 	[es:IVT8_SEGMENT_SLOT], bx
	sti

	; set main task to active
	mov     byte [task_status], 1               

	; create task a
	lea     di, [task_a]
	call    spawn_new_task

	; create task b
	lea     di, [task_b]
	call    spawn_new_task
	
	; create task c
	lea     di, [task_c]
	call    spawn_new_task
	
	; create task d
	lea     di, [task_d]
	call    spawn_new_task
	;										START PRINT DEMO
	; 16-bit version of prologue
	push    bp
	mov     bp, sp
	
	; set video to vga mode
	mov     ah, 0x0
	mov     al, 0x13
	int     0x10

	; three local stack variables, bp - 2 = row iter, bp - 4 = col iter, bp - 6 = color
	sub     sp, 6	
	
;________________________START TOP BORDER________________________________________________	
	mov 	ax, [colorLightGray]
	mov     word [bp - 6], ax       ; start at color
	mov     word [bp - 2], 2        ; start row iter at 0
	mov     word [bp - 4], 0        ; start col iter at 0
		
_draw_t_border:	
	cmp   word [bp - 4], 32         ;<number of blocks
	jl   .continue_t_border
	jmp   .done_t_border
		
	.continue_t_border:
	call _draw_block
	add     word [bp - 4], 1        ;block-sized spaces between blocks (1=adjacent)
	jmp _draw_t_border
		
	.done_t_border:
;________________________END TOP BORDER__________________________________________________

;________________________START BOTTOM BORDER_____________________________________________	
	mov     word [bp - 6], ax       ; start at color
	mov     word [bp - 2], 19       ; start row iter at 0
	mov     word [bp - 4], 0        ; start col iter at 0
		
_draw_b_border:	
		cmp   word [bp - 4], 32         ;<number of blocks
		jl   .continue_b_border
		jmp   .done_b_border
		
	.continue_b_border:
		call _draw_block
		add     word [bp - 4], 1        ;block-sized spaces between blocks (1=adjacent)
		jmp _draw_b_border
		
	.done_b_border:
;________________________END BOTTOM BORDER_______________________________________________

;________________________START LEFT BORDER_______________________________________________	
		mov     word [bp - 6], ax       ; start at color
		mov     word [bp - 2], 3        ; start row iter at 0
		mov     word [bp - 4], 0        ; start col iter at 0
		
_draw_l_border:	
		cmp   word [bp - 2], 19         ;<number of blocks
		jl   .continue_l_border
		jmp   .done_l_border
		
	.continue_l_border:
		call _draw_block
		add     word [bp - 2], 1        ;block-sized spaces between blocks (1=adjacent)
		jmp _draw_l_border
		
	.done_l_border:
;________________________END LEFT BORDER_________________________________________________

;________________________START RIGHT BORDER______________________________________________	
		mov     word [bp - 6], ax       ; start at color
		mov     word [bp - 2], 3        ; start row iter at 0
		mov     word [bp - 4], 31       ; start col iter at 0
		
_draw_r_border:	
		cmp   word [bp - 2], 19         ;<number of blocks
		jl   .continue_r_border
		jmp   .done_r_border
		
	.continue_r_border:
		call _draw_block
		add     word [bp - 2], 1        ;block-sized spaces between blocks (1=adjacent)
		jmp _draw_r_border
		
	.done_r_border:
;________________________END RIGHT BORDER________________________________________________

;________________________START SNAKE BLOCK_______________________________________________
mov		dx, [colorBlue]
mov     si, 9        
mov     di, 9

call _draw_snake_block
mov     si, 9        
mov     di, 9
mov 	[left_right], di
mov 	[up_down], si
;__________________________END SNAKE BLOCK_______________________________________________



.loop_forever_main:                     ; have main print for eternity

	call    yield	                    ; yield to next waiting task
	mov     ah, 0x0                     ; wait for user input
	int     0x16
	jmp     .loop_forever_main
;______________________________________________________________________________
; di should contain the address of the function to run for a task
spawn_new_task:
	lea     bx, [stack_pointers]        ; get the location of the stack pointers
    add     bx, [current_task]          ; get the location of the current stack pointer
	mov     [bx], sp                    ; save current stack so we can switch back
	mov     cx, [current_task]          ; look for a new task 
	add     cx, 2                       ; start searching at the next one though
.sp_loop_for_available_stack:
	cmp     cx, [current_task]          ; we are done when we get back to the original
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

task_a: ;music task
.loop_forever_1:
	
	
	call    yield
	jmp     .loop_forever_1
	; does not terminate or return


	
task_b: ;drawing task
.loop_forever_3:

;you guys might want to check this...

	mov 	ax, 0x0
	int 	0x16

	cmp 	ax, 0
	je 		.skip
	mov     bl, [direction]  ;saves previous direction
	mov     [previous_direction], bl
	mov     [direction], al

	cmp     word [direction], 119
    je      .checkup
    cmp     word [direction], 97
    je      .checkleft
    cmp     word [direction], 115
    je      .checkdown 
    cmp     word [direction], 100
    je      .checkright 
	
.checkup:
	cmp word [previous_direction], 115
	je .badmove
	jmp .skip
.checkleft:
	cmp word [previous_direction], 100
	je .badmove
	jmp .skip
.checkdown:
	cmp word [previous_direction], 119
	je .badmove
	jmp .skip
.checkright:
	cmp word [previous_direction], 97
	je .badmove
	jmp .skip

.badmove:
	mov al, [previous_direction]
	mov [direction], al
.skip:
	call    yield
	jmp     .loop_forever_3
	; does not terminate or return

task_c: ;input task
.loop_forever_2:
	
	call    yield
	jmp     .loop_forever_2
	; does not terminate or return
	
task_d: ; random food placement task
.loop_forever_4:

	call    yield
	jmp     .loop_forever_4
	; does not terminate or return
	
;________________________DRAW BLOCK FUNCTION_____________________________________________
;| di - row | si - column | dx - color |
_draw_block:
	push 	ax
	mov     ax, [bp - 2]            ; copy row iter
	mov     bx, 10                  ; block height
	imul    bx
	
	mov     di, ax                  ; row offset
	mov     ax, [bp - 4]            ; copy col iter
	imul    bx
	
	mov     si, ax                  ; column offset
	mov     dx, [bp - 6]
	
	push    bp                      ; 16-bit version of prolog
	mov     bp, sp
	mov     bx, 10                  ; block width
	sub     sp, 6                   ; three local variables, bp - 2 = row iter, bp - 4 = col iter, bp - 6 = color
	mov     [bp - 6], dx
	mov     ax, 0xA000
	mov     es, ax                  ; need location in memory to write to
	mov     word [bp - 2], 0        ; row iter
.row_loop:
	cmp     word [bp - 2], 10       ; < 10
	jne     .continue_row
	jmp     .done_row
	
.continue_row:
	mov     word [bp - 4], 0        ; col iter
.column_loop:
	cmp     word [bp - 4], 10       ; < 10
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
	pop 	ax
	ret
;________________________END DRAW BLOCK FUCTION__________________________________________

;________________________START SNAKE BLOCK FUCTION_______________________________________

	; di = row
	; si = column
	_draw_snake_block:

	mov     word [bp - 4], si
	mov     word [bp - 2], di

	; Draw initial black square
	mov		ax, [colorBlack]
	mov     word [bp - 6], ax
	call _draw_block

	; Make the segments green
	mov 	ax, [colorLightGreen]
	mov 	word [bp - 6], ax
	
	mov     ax, [bp - 2]            ; copy row iter
	mov     bx, 10                  ; block height
	imul    bx
	
	mov     di, ax                  ; row offset
	mov     ax, [bp - 4]            ; copy col iter
	imul    bx
	
	mov     si, ax                  ; column offset
	mov     dx, [bp - 6]
	
	push    bp                      ; 16-bit version of prolog
	mov     bp, sp
	mov     bx, 10                  ; block width
	sub     sp, 6                   ; three local variables, bp - 2 = row iter, bp - 4 = col iter, bp - 6 = color
	mov     [bp - 6], dx
	mov     ax, 0xA000
	mov     es, ax                  ; need location in memory to write to
	mov     word [bp - 2], 1        ; row iter
.row_loop:
	cmp     word [bp - 2], 9       ; < 10
	jne     .continue_row
	jmp     .done_row
	
.continue_row:
	mov     word [bp - 4], 1        ; col iter
	
.column_loop:
	cmp     word [bp - 4], 9       ; < 10
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
;________________________END SNAKE BLOCK FUCTION_________________________________________
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

timerHandler:
	push 	bx
	mov 	bx, [tickCounter]
	; Tick every ~0.22 seconds (4/18.2)
	cmp 	bx, 0x4
	je 		.resetTickCounter
	inc 	bx
	mov 	[tickCounter], bx
	pop 	bx
	jmp	far [cs:ivt8_offset]

	.resetTickCounter:
	xor 	bx, bx
	mov 	[tickCounter], bx
	pop 	bx
	call 	tick
	jmp	far [cs:ivt8_offset]



; Everything in this function gets executed each clock tick
tick:
	pusha
	
	call movesnake
	
	popa
	ret

movesnake:
cmp     word [direction], 119
    je      .up
    cmp     word [direction], 97
    je      .left
    cmp     word [direction], 115
    je      .down 
    cmp     word [direction], 100
    je      .right 

	
.up:
    sub     word [up_down], 1
	mov 	di, word [up_down]
	mov 	si, word [left_right]
    call    _draw_snake_block
    jmp     .again
.left:
    sub     word [left_right], 1
	mov 	si, word [left_right]
	mov 	di, word [up_down]
    call    _draw_snake_block
    jmp     .again
.down:
    add     word [up_down], 1
	mov 	di, word [up_down]
	mov 	si, word [left_right]
    call    _draw_snake_block
    jmp     .again
.right:
    add     word [left_right], 1
	mov 	si, word [left_right]
	mov 	di, word [up_down]
    call    _draw_snake_block
    jmp     .again

.again:
	ret
	

timerdemo:
	mov     si, [testCounter]
	cmp 	si, 0xF
	je		.endTdemo
	mov     di, 5
	call	_draw_snake_block
	mov 	dx, [testCounter]
	inc 	dx
	mov 	[testCounter], dx
	.endTdemo:
	ret

SECTION .data
task_main_str 		db "I am task MAIN", 13, 10, 0
task_a_str 			db "I am the music task", 13, 10, 0
left_right			dw 0
up_down 			dw 0
direction  			dw 0
previous_direction  dw 0
task_d_str 			db "I am the random food task", 13, 10, 0
score               dw 0
digits		        db	"0123456789abcdef"

current_task 		dw 0 ; must always be a multiple of 2
stacks 				times (256 * 31) db 0 ; 31 fake stacks of size 256 bytes
task_status 		times 32 dw 0 ; 0 means inactive, 1 means active
stack_pointers 		dw 0 ; the first pointer needs to be to the real stack !
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

tickCounter			dw	0
ivt8_offset			dw	0
ivt8_segment		dw	0

colorBlack     		dw 0x0
colorBlue      		dw 0x1
colorGreen     		dw 0x2
colorAqua        	dw 0x3
colorRed         	dw 0x4
colorPurple      	dw 0x5
colorYellow      	dw 0x6
colorLightGray   	dw 0x7
colorDarkGray    	dw 0x8
colorLightBlue   	dw 0x9
colorLightGreen  	dw 0xA
colorLightAqua   	dw 0xB
colorLightRed    	dw 0xC
colorLightPurple 	dw 0xD
colorLightYellow	dw 0xE
colorWhite       	dw 0xF

IVT8_OFFSET_SLOT	equ	4 * 8
IVT8_SEGMENT_SLOT	equ	IVT8_OFFSET_SLOT + 2



testCounter:       	dw 2