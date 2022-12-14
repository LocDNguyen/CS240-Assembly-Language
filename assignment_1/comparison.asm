;***************************************************************************************************************************
;Program name: "Comparing Floats". This program takes the input of multiple float numbers from the standard input device   *
;using a single instruction and the output of multiple float numbers to the standard output device also using a single     *
;instruction.  Copyright (C) 2022 Loc Nguyen.                                                                              *
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
;  Program name: Comparing Floats
;  Programming languages: Two modules in C++ and one module in X86
;  Date program began: 2022-Aug-24
;  Date of last update: 2022-Sep-3
;  Date of reorganization of comments: 2022-Sep-3
;  Files in this program: driver.cpp, isfloat.cpp, comparison.asm, run.sh
;  Status: Finished. The program was tested extensively with no errors in Fedora 36.
;
;This file
;   File name: comparison.asm
;   Language: X86 with Intel syntax.
;   Max page width: 133 columns
;   Assemble: nasm -f elf64 -l comparison.lis -o comparison.o comparison.asm


;===== Begin code area ============================================================================================================
extern printf
extern scanf
extern atof
extern isfloat

global start

segment .data
inputprompt db "Please enter two float numbers separated by white space. Press enter after the second input.", 10, 10, 0
return db "The larger number is %.13lf.", 10, 10, 0
testing db "HERE.", 10, 10, 0
two_float_format db "%s %s", 0
output_two_float db 10, "These numbers were entered:", 10,"%.13lf", 10,"%.13lf", 10, 10, 0
end db "This assembly module will now return execution to the driver module.", 10, 0
end2 db "The smaller number will be returned to the driver.", 10, 10, 0
errormessage db 10, "An invalid input was detected. You may run this program again.", 10, 10, 0

prompt db "Please enter your age or cntl+d to decline: ", 0
accept db "Thank you. Your age is recorded as %ld.", 10, 0
decline db "Thank you. Your age is recorded as Decline to State", 10, 0
string_format db "%s", 0
segment .bss  ;Reserved for uninitialized data

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



;Display a prompt message asking for inputs
mov rax, 0
mov rdi, promt           ;"Please enter two float numbers separated by white space. Press enter after the second input."
call printf


;Taking 2 float number inputs
sub rsp, 2048
mov rax, 0
mov rdi, two_float_format      ;"%s %s"
mov rsi, rsp                   ;rsi points to first quadword on the stack
mov rdx, rsp
add rdx, 1024                     ;rdx points to second quadword on the stack
mov r14, rsp
mov r15, rdx
call scanf


;Validating both inputs if they are floats
mov rax, 0
mov rdi, r14
call isfloat                   ;If not a float, jump to error
cmp rax, 0
je error

mov rax, 0
mov rdi, r15
call isfloat
cmp rax, 0
je error

;Convert valid values to floats and store them
mov rax, 0
mov rdi, r14
call atof
movsd xmm8, xmm0

mov rax, 0
mov rdi, r15
call atof
movsd xmm9, xmm0

jmp inputted


error:
;Display error message and return -1
mov rax, 0
mov rdi, errormessage          ;"An invalid input was detected. You may run this program again."
call printf

add rsp, 2048

mov rax, -1
cvtsi2sd xmm10, rax
movsd xmm0, xmm10              ;Return -1 to the caller
jmp restore                    ;Jump to area that restores original values to integer registers and exit


inputted:
;Display the two numbers inputted
mov rax, 2                     ;printf will need to access this many SSE registers.
mov rdi, output_two_float      ;"The two numbers inputted are %1.15lf and %1.15lf"
movsd xmm0, xmm8
movsd xmm1, xmm9
movsd xmm14, xmm8              ;Make a backup copy
movsd xmm15, xmm9              ;Make a backup copy
call printf


sort:
;Sort out which of the two numbers are larger
ucomisd xmm14,  xmm15          ;Compare two floating point numbers
jbe larger                     ;Jump to block labeled "larger"
movsd xmm1, xmm14
movsd xmm14, xmm15
movsd xmm15, xmm1


larger:
;Display the larger number of the two inputs
mov rax, 1
mov rdi, return                ;"The larger number is %1.15lf."
movsd xmm0, xmm15
movsd xmm13, xmm15             ;Make a backup copy
call printf
;========== Prepare to exit from this program ==================================================================

;Display good-bye messages
mov rax, 0
mov rdi, end                   ;"This assembly module will now return execution to the driver module."
call printf

mov rax, 0
mov rdi, end2                  ;"The smaller number will be returned to the driver."
call printf

add rsp, 2048                  ;Reverse the sub near the beginning of this asm function.

movsd xmm0, xmm14              ;Select the smaller value for return to caller.

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
