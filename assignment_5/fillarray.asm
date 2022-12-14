;=====================================================================================================================================
;Program Name: Arrays
;Programming Language: x86 Assembly
;File Description: This file asks the user to input as many integers in the array. User input is then determined whether
;or no the input is an integer type. If so, add it into the array, or do not add it if otherwise. To stop inputting
;values, the user is prompted to press Ctrl+D. If the array is full, the program automatically stops the user from doing so
;and moves on.


;Author: Justin Bui
;Email: Justin_Bui12@csu.fullerton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-05
;Start Date: 18 September, 2020

;Copyright (C) 2020 Justin Bui
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
;======================================================================================================================================

extern scanf
extern printf
extern isnan
; extern isinteger			;From isinteger.asm
; extern atolong				;From atol.asm
; extern printArray
global fillarray

section .data
	integerOutputFormat db "%ld", 10, 0
	stringOutputFormat db "%s", 0

section .bss
	;Nothing declared inside .bss

section .text
fillarray:

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

startOfLoop:

    rdrand r15
	cvtsi2sd xmm15, r15

;Checking nan
 mov rbx, [rsp]
 mov rcx, 0x7ff0000000000000    ;isolate the relevant bits
 and rbx, rcx
 shr rbx, 52                    ;all isolated bits are at the right
 cmp rbx, 2047                  ;compare those isolated bits to 0b11111111111

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
