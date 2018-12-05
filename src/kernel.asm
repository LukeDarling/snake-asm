; Snake-ASM
; A classic Snake game written in Assembly.
; Written by Amy Surrett, Jonathan DeGirolano, and Luke Darling.

bits 16

org 0

SECTION	.text

main:



.main:
mov     ah, 0x0                     ; wait for user input
int     0x16


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
mov 	al, [left_right]
mov 	ah, [up_down]
call 	_push

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

	mov 	ax, 0x10
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

;needs to be here because the value of the base pointer needs to be
;set to si and di and the _draw_block funtion then can be called 

_draw_snake_block_2:

	mov     word [bp - 4], si
	mov     word [bp - 2], di

	; Draw initial black square
	mov		ax, [colorAqua]
	mov     word [bp - 6], ax
	call _draw_block
	ret

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

; print NUL-terminated string from DS:DX to the screen (at the current "cursor" location) using BIOS INT 0x10
; takes NUL-terminated string pointed to by DS:DX
; clobbers nothing
; returns nothing
puts:
    push    ax
    push    cx
    push    si
    mov ah, 0x0e
    mov cx, 1       ; no repetition of chars
    mov si, dx
.loop:  mov al, [si]
    inc si
    cmp al, 0
    jz  .end
    int 0x10
    jmp .loop
.end:
    pop si
    pop cx
    pop ax
    ret


timerHandler:
	push 	bx
	mov 	bx, [tickCounter]
	; Tick every ~0.11 seconds (2/18.2)
	cmp 	bx, [tickSpeed]
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
	call doMusic
	
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
	call    _pop
    sub     word [up_down], 1
	cmp 	word [up_down], 2
	je 		.not_alive 
	mov 	di, word [up_down]
	mov 	si, word [left_right]
    call    _draw_snake_block
	mov 	ah, [left_right]
	mov 	al, [up_down]
	call	_push

    jmp     .again
.left:
	call    _pop
    sub     word [left_right], 1
	cmp 	word [left_right], 0
	je 		.not_alive
	mov 	si, word [left_right]
	mov 	di, word [up_down]
    call    _draw_snake_block
	mov 	ah, [left_right]
	mov 	al, [up_down]
	call	_push

    jmp     .again
.down:
	call    _pop
    add     word [up_down], 1
	cmp 	word [up_down], 19
	je 		.not_alive
	mov 	di, word [up_down]
	mov 	si, word [left_right]
    call    _draw_snake_block
	mov 	ah, [left_right]
	mov 	al, [up_down]
	call	_push			
    jmp     .again
.right:
	call    _pop
    add     word [left_right], 1
	cmp 	word [left_right], 31
	je 		.not_alive
	mov 	si, word [left_right]
	mov 	di, word [up_down]
    call    _draw_snake_block
	mov 	ah, [left_right]
	mov 	al, [up_down]
	call	_push

    jmp     .again

.not_alive:
	mov 	word [dead], 1

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

doMusic:
	MOV     DX,2000          ; Number of times to repeat whole routine.

MOV     BX,1             ; Frequency value.

MOV     AL, 10110110B    ; The Magic Number (use this binary number only)
OUT     43H, AL          ; Send it to the initializing port 43H Timer 2.

NEXT_FREQUENCY:          ; This is were we will jump back to 2000 times.

MOV     AX, BX           ; Move our Frequency value into AX.

OUT     42H, AL          ; Send LSB to port 42H.
MOV     AL, AH           ; Move MSB into AL  
OUT     42H, AL          ; Send MSB to port 42H.

IN      AL, 61H          ; Get current value of port 61H.
OR      AL, 00000011B    ; OR AL to this value, forcing first two bits high.
OUT     61H, AL          ; Copy it to port 61H of the PPI Chip
                         ; to turn ON the speaker.

MOV     CX, 100          ; Repeat loop 100 times
DELAY_LOOP:              ; Here is where we loop back too.
LOOP    DELAY_LOOP       ; Jump repeatedly to DELAY_LOOP until CX = 0


INC     BX               ; Incrementing the value of BX lowers 
                         ; the frequency each time we repeat the
                         ; whole routine

DEC     DX               ; Decrement repeat routine count

CMP     DX, 0            ; Is DX (repeat count) = to 0
JNZ     NEXT_FREQUENCY   ; If not jump to NEXT_FREQUENCY
                         ; and do whole routine again.

                         ; Else DX = 0 time to turn speaker OFF

IN      AL,61H           ; Get current value of port 61H.
AND     AL,11111100B     ; AND AL to this value, forcing first two bits low.
OUT     61H,AL           ; Copy it to port 61H of the PPI Chip
                         ; to turn OFF the speaker.
	ret

	_push: 
    mov     dx, ax
    mov     cx, [stack_it]
    lea     bx, [new_stack]
    add     bx, cx
    mov     [bx], dx
    add     word [stack_it], 2
    ret

_pop:   
	sub 	word [stack_it], 2
	mov 	cx, [stack_it]
    lea     bx, [new_stack]
    add     bx, cx 
    mov     ax, [bx]
	mov 	[black_it_right_left], al
	mov 	[black_it_up_down], ah
	mov 	si, [black_it_up_down]
	mov 	di, [black_it_right_left]
	call 	_draw_snake_block_2
    ret 
	
SECTION .data
start_str           db "Snake game by A.S., L.D. J. DG", 13, 10, 0
start_str_2         db "Press any key to continue ...", 13, 10, 0
task_main_str 		db "I am task MAIN", 13, 10, 0
task_a_str 			db "I am the music task", 13, 10, 0
left_right			dw 0
up_down 			dw 0
direction  			dw 0
previous_direction  dw 0
task_d_str 			db "I am the random food task", 13, 10, 0
score               dw 0
digits		        db	"0123456789abcdef"
length_of_snake   	db 4
black_it_right_left db 0
black_it_up_down    db 0
dead				db 0


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



testCounter       	dw 2
stack_it 			dw 0

tickSpeed			dw 0x12

section .bss

    new_stack resw 1000