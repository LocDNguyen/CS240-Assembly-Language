;************************************************************************************************************************
;Program name: "ftoa".  This program accepts an array of char and a float number and converts the number into its ascii *
;value.  This is a library function not specific to any one program.  Copyright (C) 2022 Loc Nguyen                     *
;                                                                                                                       *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public      *
;License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will  *
;be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR  *
;PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public License v3 is         *
;available here:  <https://www.gnu.org/licenses/>.                                                                      *
;************************************************************************************************************************
;
;Author information
;   Author name: Loc Nguyen
;   Author's email: lnguy121@csu.fullerton.edu
;
;Function information
;   Function name: ftoa
;   Programming language: X86
;   Language syntax: Intel
;   Function prototype:  void ftoa(double value, char * string)
;   Reference: None
;   Input parameter: The char array and float number
;   Output parameter: A pointer to char array of inputted float number
;
;Assemble: nasm -f elf64 -o ftoa.o -l ftoa.lis ftoa.asm
;
;Date development began: 2018-Oct-29
;Date comments restructured: 2022-Oct-29
;
;===== Begin executable code section ====================================================================================

global ftoa
; external functions

; constant declarations

segment .data
; initialized variable declarations
neg_one dq -1.0
one dq 1.0
period dq '.'
limit db 10

segment .bss
;This segment is empty

segment .text
;This segment is empty

ftoa:

; Prolog ===== Insurance for any caller of this assembly module ========================================================
push rbp
mov  rbp,rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf


movsd xmm15, xmm0      ;carries the float that was passed
mov rbx, rdi           ;carries the char array that was passed


mov r11, 10            ;digit limit
mov r12, 0             ;char pointer counter
mov r13, 0             ;decimal counter
mov r14, 0             ;stack counter

; check if negative
mov rax, 0
cvtsi2sd xmm11, rax         ;xmm11 has 0.0 in it now
ucomisd xmm15, xmm11
jae start

mov byte [rbx], '-'
mulsd xmm15, [neg_one]
inc r12

start:

; check if float - interger portion of float = 0?
move_decimal:
cvtsd2si r10, xmm15      ;original number in xmm15 ie:34.5
cvtsi2sd xmm14, r10      ;xmm14 has integer number of original number ie:34

movsd xmm13, xmm15       ;make copy of original number
subsd xmm13, xmm14       ;subtract original number from integer number ie:34.5 - 34
ucomisd xmm13, xmm11     ;compare original number to 0
je convert
cmp r11, 0
je convert

mov rax, 10
cvtsi2sd xmm12, rax
mulsd xmm15, xmm12       ;multiply original number by 10 to move the decimal point
inc r13                  ;count how many times the decimal point was moved so we can move it back later
dec r11
jmp move_decimal


convert:
cvtsd2si r15, xmm15        ;convert float to int

decimal_to_ascii:
cmp r13, 0
je part_two

mov rax, r15              ;remove LSD
cqo
mov r15, 10
idiv r15
mov r15, rax              ;keep track of quotient for continuation to part two

add rdx, '0'              ;convert and push onto stack
push rdx

dec r13
inc r14
jmp decimal_to_ascii

part_two:

push qword '.'
inc r14

integer_to_ascii:
mov rax, r15             ;remove LSD
cqo
mov r15, 10
idiv r15
mov r15, rax             ;when quotient is 0 we know to stop
cmp r15, 0
je push_last

add rdx, '0'             ;convert and push onto stack
push rdx

dec r13
inc r14
jmp integer_to_ascii


;convert and push the last digit
push_last:
add rdx, '0'
push rdx
inc r14

;load char pointer
load_return:
cmp r14, 0
je done

pop rax
mov [rbx + r12], rax
inc r12
dec r14
jmp load_return

done:
inc r12
mov byte [rbx + r12], 0     ;add null terminator for our string

;===== Restore original values to integer registers ===================================================================
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp

ret
