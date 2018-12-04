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

MOV     CX, 1000          ; Repeat loop 100 times
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

;Read more: http://www.intel-assembler.it/portale/5/make-sound-from-the-speaker-in-assembly/8255-8255-8284-asm-program-example.asp#ixzz5YhWcUl53
	
	;cli
	;mov	al,00110110b  ; bit 7,6 = (00) timer counter 0
			      ; bit 5,4 = (11) write LSB then MSB
			      ; bit 3-1 = (011) generate square wave
			      ; bit 0 = (0) binary counter
	;out	43h,al	      ; prep PIT, counter 0, square wave&init count
	;jmp	$+2
	;mov	cx,countdown  ; default is 0x0000 (65536) (18.2 per sec)
			      ; interrupts when counter decrements to 0
	;mov	al,cl	      ; send LSB of timer count
	;out	40h,al
	;jmp	$+2
	;mov	al,ch	      ; send MSB of timer count
	;out	40h,al
	;jmp	$+2
	;sti
	
	mov     ah, 0x0                 ; wait for user input
	int     0x16
		
	;jmp .mainloop
.done:	
	mov     ah, 0x0                 ; wait for user input
	int     0x16
	
	mov     ah, 0x4c                ; exit
	mov     al, 0
	int     0x21
	


section	.data
countdown  equ	8000h ; approx 36 interrupts per second
digits		db	"0123456789abcdef"
score		dw	0
ivt8_offset	dw	0
ivt8_segment	dw	0
msg_finish	db	"Enter an empty string to quit...", 10, 13, 10, 13, 0
msg_prompt	db	"What is your name? ", 0
msg_hello	db	"Why, hello, ", 0
msg_bangbang	db	"!!", 10, 13, 0
input_buff	times 32 db 0
