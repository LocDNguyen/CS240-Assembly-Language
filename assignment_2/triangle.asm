;***************************************************************************************************************************
; Program name: "Getting Hypotenuse". This program takes the input of strings as well as displays those strings after the  *
; exit of the program. The program also takes two float numbers from the standard input device and performs some arithmetic*
; in order to oouput to the user the hypotenuse of the two float numbers. If an invalid float input is inputted, the       *
; program will continue to ask for valid float inputs until two are given.  Copyright (C) 2022 Loc Nguyen.                 *
;                                                                                                                          *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
;version 3 as published by the Free Software Foundation.                                                                   *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                           *
;***************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Loc Nguyen
;  Author email: lnguy121@csu.fullerton.edu
;
;Program information
;  Program name: Getting Hypotenuse
;  Programming languages: One module in C and one module in X86
;  Date program began: 2022-Sep-7
;  Date of last update: 2022-Sep-19
;  Date of reorganization of comments: 2022-Sep-19
;  Files in this program: driver.c, triangle.asm, run.sh
;  Status: Finished. The program was tested extensively with no errors in Fedora 36
;                    as well as assuming that the user will not input a string when a float input is needed.
;
;This file
;   File name: triangle.asm
;   Language: X86 with Intel syntax.
;   Max page width: 133 columns
;   Assemble: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm


;===== Begin code area ============================================================================================================
extern printf
extern scanf
extern fgets
extern stdin
extern strchr

global start

segment .data
inputprompt db "Please enter your last name: ", 0
inputprompt2 db 10, "Please enter your title (Mr, Ms, Nurse, Engineer, etc): ", 0
inputprompt3 db 10, "Please enter the sides of your triangle separated by whitespace: ", 0
one_string_format db "%s", 0
two_float_format db "%lf %lf", 0
end db "Please enjoy your triangles %s %s", 10, 10, 0
errormessage db 10, "An invalid input was detected.", 10, 0
output_two_float db "The two numbers are %5.3lf and %5.3lf.", 10, 0
hypotenuse db 10, "The length of the hypotenuse is %.9lf units.", 10, 10, 0



segment .bss  ;Reserved for uninitialized data
name resb 32
title resb 32

segment .text ;Reserved for executing instructions.

start:

;Prolog ===== Insurance for any caller of this assembly module ====================================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags



;Display a prompt message asking for first input
mov rax, 0
mov rdi, inputprompt           ;"Please enter your last name."
call printf
;Taking first string input
mov rax, 0
mov rdi, name                  ;"%s"
;mov rsi, 32                    ;rsi points to first input on the stack ;;;;;;do I need this?/what does it do
mov rdx, [stdin]
call fgets

mov rax, 0
mov rdi, name
mov rsi, 10
call strchr
mov byte [rax], 0

;Display a prompt message asking for second input
mov rax, 0
mov rdi, inputprompt2             ;"Please enter your title (Mr, Ms, Nurse, Engineer, etc): "
call printf

mov rax, 0                        ;No xmm registers
mov rdi, title                    ;Copy to rdi the pointer to the start of the array of 32 bytes
mov rsi, 32                       ;Provide to fgets the size of the storage made available for input
mov rdx, [stdin]
call fgets


mov rax, 0
mov rdi, title
mov rsi, 10
call strchr
mov byte [rax], 0
jmp floats

error:
mov rax, 0
mov rdi, errormessage           ;Invalid input
add rsp, 2048
call printf

;Display a prompt message asking for two input floats
floats:
mov rax, 0
mov rdi, inputprompt3           ;"Please enter the sides of your triangle separated by whitespace"
call printf

sub rsp, 2048
mov rax, 0
mov rdi, two_float_format      ;"%lf%lf"
mov rsi, rsp
mov rdx, rsp
add rdx, 1024
call scanf


movsd xmm14, [rsp]             ;Moving inputs to xmm registers
movsd xmm15, [rsp+1024]

xorpd xmm13, xmm13             ;Putting the number 0 into xmm13

ucomisd xmm14, xmm13           ;Comparing the user input number to the number 0
jbe error
ucomisd xmm15, xmm13
jbe error

add rsp, 2048

mulsd xmm14, xmm14             ;Squaring both inputs then adding them together to get hypotenuse
mulsd xmm15, xmm15

addsd xmm14, xmm15

;Display the hypotenuse
mov rax, 1
mov rdi, hypotenuse
movsd xmm0, xmm14
call printf

;area of triangle
;mulsd xmm14, xmm15
;mov rbx, 0x4000000000000000
;push rbx
;movsd xmm8, [rsp]
;divsd xmm14, xmm8

;16.0 = 0x4030 0000 0000 0000
;8.0 = 0x4020 0000 0000 0000
;4.0 - 0x4010 0000 0000 0000
;2.0 = 0x4000 0000 0000 0000
;1.0 = 0x3FF0 0000 0000 0000
;========== Prepare to exit from this program ==================================================================

;Display good-bye messages
mov rax, 0
mov rdi, end                   ;"Please enjoy your triangles %s %s"
mov rsi, title
mov rdx, name
call printf

movsd xmm0, xmm14
;===== Restore original values to integer registers ===============================================================================
restore:
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
