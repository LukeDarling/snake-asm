; CpS 230 Lab 9: Mr. J (jpjuecks)
;---------------------------------------------------
; Tiny payload program to boot-strapped from disk.
;---------------------------------------------------
bits 16

; The bootloader loads us at 0800:0000h, so our "origin" is offset 0
org	0

; Single section file (any data will sit in our code section)
section	.text

; Offset 0 into our code (starting point)
start:
	; Make sure DS == CS (assume SS is already set up/OK)
	mov	ax, cs
	mov	ds, ax
	
	; Print success message
	mov	dx, success_msg
	call	puts
	
	; Spin forever
	;jmp	$		; Jump to my own address (i.e., infinite loop)

; print NUL-terminated string from DS:DX to screen using BIOS (INT 10h)
; takes NUL-terminated string pointed to by DS:DX
; clobbers nothing
; returns nothing
puts:
	push	ax
	push	cx
	push	si
	
	mov	ah, 0x0e
	mov	cx, 1		; no repetition of chars
	
	mov	si, dx
.loop:	mov	al, [si]
	inc	si
	cmp	al, 0
	jz	.end
	int	0x10
	jmp	.loop
.end:
	pop	si
	pop	cx
	pop	ax
	ret

section .data
success_msg	db	"Yahoo, you booted successfully!", 13, 10, 0
