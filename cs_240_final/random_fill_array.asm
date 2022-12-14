;=====================================================================================================================================
;  Name: Loc Nguyen
;  Email: locdacnguyen0@gmail.com
;	This course number, namely “CPSC240-1”.
;	The words: “Final Program Test”.
;======================================================================================================================================

extern scanf
extern printf
extern isnan
; extern isinteger			;From isinteger.asm
; extern atolong				;From atol.asm
; extern printArray
global random_fill_array

section .data
	integerOutputFormat db "%ld", 10, 0
	stringOutputFormat db "%s", 0

section .bss
	;Nothing declared inside .bss

section .text
random_fill_array:

push rbp                                          ;Backup rbp
mov  rbp,rsp                                      ;The base pointer now points to top of stack
push rdi                                          ;Backup rdi
push rsi                                          ;Backup rsi
push rdx                                          ;Backup rdx
push rcx                                          ;Backup rcx
push r8                                           ;Backup r8
push r9                                           ;Backup r9
push r10                                          ;Backup r10
push r11                                          ;Backup r11
push r12                                          ;Backup r12
push r13                                          ;Backup r13
push r14                                          ;Backup r14
push r15                                          ;Backup r15
push rbx                                          ;Backup rbx
pushf                                             ;Backup rflags

	mov r14, rdi		;pointer to the array
	mov r13, rsi		;array capacity
	mov r12, 0		  ;current index of array

	; for testing hsum
	; mov r15, 132
	; jmp startOfLoop
	; changenum:
	; mov r15, 69


startOfLoop:

  rdrand r15
	cvtsi2sd xmm15, r15

	;Checking nan
	 mov rbx, [rsp]
	 mov rcx, 0x7ff0000000000000    ;isolate the relevant bits
	 and rbx, rcx
	 shr rbx, 52                    ;all isolated bits are at the right
	 cmp rbx, 2047                  ;compare those isolated bits to 0b11111111111

;Checking nan
 mov rbx, [rsp]
 mov rcx, 0x7ff0000000000000    ;isolate the relevant bits
 and rbx, rcx
 shr rbx, 52                    ;all isolated bits are at the right
 cmp rbx, 2047                  ;compare those isolated bits to 0b11111111111

 cmp rax, 1
 je startOfLoop
;Checking zeros
 mov rbx, [rsp]
 mov rcx, 0x7ff0000000000000    ;isolate the relevant bits
 and rbx, rcx
 shr rbx, 52                    ;all isolated bits are at the right
 cmp rbx, 0                  ;compare those isolated bits to 0b0

		;call nan function
    ; mov rax, 0
    ; movsd xmm0, xmm15
    ; call isnan

    cmp rax, 1
    je startOfLoop

    movsd [r14+8*r12], xmm15
    inc r12
    cmp r12, r13
    je exitProgram
    jmp startOfLoop

exitProgram:


mov qword rax, r12				;Backing up r12 into rax to be returned

	;Popping all of registers in reverse order as pushes
	pop rbx                                                     ;Restore rbx
	pop r15                                                     ;Restore r15
	pop r14                                                     ;Restore r14
	pop r13                                                     ;Restore r13
	pop r12                                                     ;Restore r12
	pop r11                                                     ;Restore r11
	pop r10                                                     ;Restore r10
	pop r9                                                      ;Restore r9
	pop r8							    ;Restore r8
	pop rcx                                                     ;Restore rcx
	pop rdx                                                     ;Restore rdx
	pop rsi                                                     ;Restore rsi
	pop rdi                                                     ;Restore rdi
	pop rbp                                                     ;Restore rbp
	pop rbx

	ret                                               ;Returning current number of items in array
