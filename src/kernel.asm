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



;________________________START SNAKE BLOCK_______________________________________________




;__________________________END SNAKE BLOCK_______________________________________________





.loop_forever_main:                     ; have main print for eternity
	cmp 	byte [dead], 1
	jne 	.endMainLoop
	cmp 	byte [running], 0
	jne 	.endMainLoop
	mov 	byte [dead], 0
	mov 	byte [running], 0
	mov 	ax, [colorBlack]
	call 	fillScreen
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 2
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 29
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 1
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 2
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightRed]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 2
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 29
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 2
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 9
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 10
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 10
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 10
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 29
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightYellow]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 2
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 29
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 2
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 29
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 2
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 29
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 17
    mov     word [bp - 4], 30
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 1
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 2
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 3
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 4
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 5
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 6
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 7
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 8
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 9
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 10
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 11
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 12
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 13
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 14
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 15
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 16
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 17
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 18
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 19
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 20
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 21
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 22
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 23
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 24
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 25
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 26
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 27
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 28
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 29
    call    _draw_block
    mov 	ax, [colorLightGreen]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 18
    mov     word [bp - 4], 30
    call    _draw_block
	.contMainLoop:
	mov 	ax, 0x0
	int 	0x16
	cmp 	bl, 20
	je 		.contMainLoop
	call 	drawBorder
    call    setup
	mov 	byte [running], 1
	.endMainLoop:
	call    yield
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

task_a:
.loop_forever_1:
	cmp 	byte [dead], 1
	jne 	.task_a_end
	cmp 	byte [running], 1
	jne 	.task_a_end
	pusha
	; Draw GAME OVER text
	mov 	ax, [colorBlack]
	call 	fillScreen
    mov 	ax, [colorWhite]
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 7
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 8
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 12
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 13
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 17
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 19
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 23
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 24
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 3
    mov     word [bp - 4], 25
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 6
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 9
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 11
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 14
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 16
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 18
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 20
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 4
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 6
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 11
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 14
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 16
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 18
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 20
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 23
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 5
    mov     word [bp - 4], 24
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 6
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 8
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 9
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 11
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 12
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 13
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 14
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 16
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 18
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 20
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 6
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 6
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 9
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 11
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 14
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 16
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 18
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 20
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 7
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 7
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 8
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 11
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 14
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 16
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 18
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 20
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 23
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 24
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 8
    mov     word [bp - 4], 25
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 7
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 8
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 11
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 15
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 17
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 18
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 19
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 20
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 23
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 11
    mov     word [bp - 4], 24
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 6
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 9
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 11
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 15
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 17
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 12
    mov     word [bp - 4], 25
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 6
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 9
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 11
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 15
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 17
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 18
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 19
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 13
    mov     word [bp - 4], 25
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 6
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 9
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 12
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 14
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 17
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 23
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 14
    mov     word [bp - 4], 24
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 6
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 9
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 12
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 14
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 17
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 15
    mov     word [bp - 4], 24
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 7
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 8
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 13
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 17
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 18
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 19
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 20
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 22
    call    _draw_block
    mov     word [bp - 6], ax
    mov     word [bp - 2], 16
    mov     word [bp - 4], 25
    call    _draw_block
	mov 	byte [running], 0
	popa
	.task_a_end:
	call    yield
	jmp     .loop_forever_1
	; does not terminate or return


	
task_b:
.loop_forever_3:

;you guys might want to check this...

	mov 	ax, 0x1
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
	jmp 	.badmove
	
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
    pusha
    cmp     byte [foodConsumed], 0
    je      .endFoodTask
    mov     bx, [foodXCounter]
    add     bx, foodXs
    mov     cx, [bx]
    mov     bx, [foodYCounter]
    add     bx, foodYs
    mov     dx, [bx]

    mov     ax, [stack_it]
    inc     ax
    .loopFoodX:
    dec     ax
    mov     bx, ax
    add     bx, snake_stack_X
    cmp     [bx], cx
    je      .newFoodItem
    cmp     ax, 0
    jg     .loopFoodX

    mov     ax, [stack_it_2]
    inc     ax
    .loopFoodY:
    dec     ax
    mov     bx, ax
    add     bx, snake_stack_Y
    cmp     [bx], dx
    je      .newFoodItem
    cmp     ax, 0
    jg     .loopFoodY

    mov     byte [foodConsumed], 0
    mov     [foodX], cx
    mov     [foodY], dx
    mov     ax, [colorLightRed]
    mov     word [bp - 6], ax
    mov     word [bp - 4], cx
    mov     word [bp - 2], dx
    call    _draw_block

    .newFoodItem:
    mov     dx, [foodXCounter]
    cmp     dx, 15
    jge      .resetFoodXCounter
    inc     dx
    mov     [foodXCounter], dx
    jmp     .foodYCounterNext
    .resetFoodXCounter:
    xor     dx, dx
    mov     [foodXCounter], dx
    .foodYCounterNext:
    mov     dx, [foodYCounter]
    cmp     dx, 14
    jge      .resetFoodYCounter
    inc     dx
    mov     [foodYCounter], dx
    jmp     .endFoodTask
    .resetFoodYCounter:
    xor     dx, dx
    mov     [foodYCounter], dx
    .endFoodTask:
    mov     ax, [snakeX]
    mov     dx, [snakeY]
    cmp     ax, [foodX]
    jne     .endFoodCheck
    cmp     dx, [foodY]
    jne     .endFoodCheck
    mov     byte [foodConsumed], 1
    jmp     .skipPop
    .endFoodCheck:
    .skipPop:


    popa
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
	mov		ax, [colorBlack]
	mov     word [bp - 6], ax
	call _draw_block
	ret

;________________________START SNAKE BLOCK FUCTION_______________________________________

	;di = row
	;si = column
	_draw_snake_block:
	;mov [lr], di
	;mov [ud], si 
	;mov al, [ud]
	;mov ah, [lr]
	
	
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


drawBorder:
	mov 	ax, [colorBlack]
	call 	fillScreen
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
	ret

; Everything in this function gets executed each clock tick
tick:
	pusha
	
	cmp 	byte [running], 1
	jne 	.endTick
	cmp 	byte [dead], 0
	jne 	.endTick

	call 	movesnake
	call 	doMusic
	
	.endTick:
	popa
	ret

fillScreen:
	push 	bx
	push 	ax
	mov     ax, 0xA000
	mov     es, ax
	pop 	ax
	xor 	bx, bx
	.drawFiller:
	mov     [es:bx], ax
	inc 	bx
	cmp 	bx, 0xFA00
	jne 	.drawFiller
	pop 	bx
	ret

movesnake:
    pusha



    cmp     word [direction], 119
    je      .up
    cmp     word [direction], 97
    je      .left
    cmp     word [direction], 115
    je      .down 
    cmp     word [direction], 100
    je      .right 

	
.up:
    mov     ax, [snakeX]
    mov     dx, [snakeY]
    cmp     ax, [foodX]
    jne     .endFoodCheck1
    cmp     dx, [foodY]
    jne     .endFoodCheck1
    mov     byte [foodConsumed], 1
    jmp     .skipPop1
    .endFoodCheck1:
    call    _pop
    .skipPop1:
    sub     word [snakeY], 1
	cmp 	word [snakeY], 2
	je 		.not_alive 
	mov 	di, word [snakeY]
	mov 	si, word [snakeX]
    call    _draw_snake_block
	mov 	dx, [snakeX]
	mov 	ax, [snakeY]
	call	_push

    jmp     .again
.left:
    mov     ax, [snakeX]
    mov     dx, [snakeY]
    cmp     ax, [foodX]
    jne     .endFoodCheck2
    cmp     dx, [foodY]
    jne     .endFoodCheck2
    mov     byte [foodConsumed], 1
    jmp     .skipPop2
    .endFoodCheck2:
    call    _pop
    .skipPop2:
    sub     word [snakeX], 1
	cmp 	word [snakeX], 0
	je 		.not_alive
	mov 	si, word [snakeX]
	mov 	di, word [snakeY]
    call    _draw_snake_block
	mov 	dx, [snakeX]
	mov 	ax, [snakeY]
	call	_push

    jmp     .again
.down:
    mov     ax, [snakeX]
    mov     dx, [snakeY]
    cmp     ax, [foodX]
    jne     .endFoodCheck3
    cmp     dx, [foodY]
    jne     .endFoodCheck3
    mov     byte [foodConsumed], 1
    jmp     .skipPop3
    .endFoodCheck3:
    call    _pop
    .skipPop3:
    add     word [snakeY], 1
	cmp 	word [snakeY], 19
	je 		.not_alive
	mov 	di, word [snakeY]
	mov 	si, word [snakeX]
    call    _draw_snake_block
	mov 	dx, [snakeX]
	mov 	ax, [snakeY]
	call	_push			
    jmp     .again
.right:
    mov     ax, [snakeX]
    mov     dx, [snakeY]
    cmp     ax, [foodX]
    jne     .endFoodCheck4
    cmp     dx, [foodY]
    jne     .endFoodCheck4
    mov     byte [foodConsumed], 1
    jmp     .skipPop4
    .endFoodCheck4:
    call    _pop
    .skipPop4:
    add     word [snakeX], 1
	cmp 	word [snakeX], 31
	je 		.not_alive
	mov 	si, word [snakeX]
	mov 	di, word [snakeY]
    call    _draw_snake_block
	mov 	dx, [snakeX]
	mov 	ax, [snakeY]
	call	_push

    jmp     .again

.not_alive:
	mov 	byte [dead], 1

.again:
    popa
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


setup:
    ; Add initial snake block to the stack

    mov     word [stack_it], 0
    mov     word [stack_it_2], 0
    mov     word [length_of_snake], 0

    mov 	dx, 9
    mov 	ax, 9
    call 	_push
    mov     dx, 9
    mov     ax, 10
    call    _push
    mov     dx, 9
    mov     ax, 11
    call    _push
    mov     word [snakeX], 9
    mov     word [snakeY], 11
    ret

_push: 
    add     word [length_of_snake], 2
    mov     cx, [stack_it]
    lea     bx, [snake_stack_X]
    add     bx, cx
    mov     [bx], dx
    add     word [stack_it], 2

    mov     cx, [stack_it_2]
    lea     bx, [snake_stack_Y]
    add     bx, cx
    mov     [bx], ax
    add     word [stack_it_2], 2

    ret

_pop:   
	mov 	dx, [length_of_snake]
	mov 	cx, [stack_it]
	sub 	cx, dx
    mov     [stack_it], cx
    lea     bx, [snake_stack_X]
    add     bx, cx 
    mov     dx, [length_of_snake]
    add     cx, dx
    mov     [stack_it], cx
    mov     ax, [bx]

    mov 	dx, [length_of_snake]
	mov 	cx, [stack_it_2]
	sub 	cx, dx
    lea     bx, [snake_stack_Y]
    add     bx, cx 
    mov     dx, [length_of_snake]
    add     cx, dx
    mov     [stack_it_2], cx
    mov     dx, [bx]

	mov 	[black_it_right_left], dx
	mov 	[black_it_snakeY], ax
	mov 	si, [black_it_snakeY]
	mov 	di, [black_it_right_left]
	call 	_draw_snake_block_2

    sub     word [length_of_snake], 2

    ret 
	
SECTION .data
start_str           db "Snake game by A.S., L.D. J. DG", 13, 10, 0
start_str_2         db "Press any key to continue ...", 13, 10, 0
task_main_str 		db "I am task MAIN", 13, 10, 0
task_a_str 			db "I am the music task", 13, 10, 0
snakeX		    	dw 0
snakeY 			    dw 0
direction  			dw 0
previous_direction  dw 0
task_d_str 			db "I am the random food task", 13, 10, 0
score               dw 0
digits		        db	"0123456789abcdef"
length_of_snake   	dw 2
black_it_right_left dw 0
black_it_snakeY    dw 0
dead				db 1
running 			db 0
lr                  db 0
ud                  db 0


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
stack_it_2          dw 0

foodX               dw 0
foodY               dw 0
foodXCounter        dw 0
foodYCounter        dw 0
foodXs              dw 7, 30, 14, 6, 6, 17, 2, 5, 24, 27, 11, 8, 29, 22, 15, 1
foodYs              dw 15, 4, 7, 13, 2, 9, 2, 11, 14, 1, 5, 8, 14, 6, 12

foodConsumed        db 1

; Tick every ~0.16 seconds (3/18.2)
tickSpeed			dw 0x3

section .bss

    snake_stack_X       resw 1000
    snake_stack_Y     resw 1000