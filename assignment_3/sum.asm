; ***************************************************************************************************************************
; Program name: "Adding Integers Array". This program takes a string input as well as a sequence of integer inputs.         *
; The program then displays the integer inputs that were put in an array as well as sums all the integers. The program then *
; returns the string input and exits. Copyright (C) 2022 Loc Nguyen.                                                        *
;                                                                                                                           *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
; version 3 as published by the Free Software Foundation.                                                                   *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
; A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                           *
; ***************************************************************************************************************************
;
;
; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
;
; Author information
;   Author name: Loc Nguyen
;   Author email: lnguy121@csu.fullerton.edu
;
; Program information
;   Program name: Adding Integers Array
;   Programming languages: One module in C, two modules in C++, 4 modules in X86, and one module in bash
;   Date program began: 2022-Sep-28
;   Date of last update: 2022-Oct-9
;   Date of reorganization of comments: 2022-Oct-9
;   Files in this program: driver.c, display_array.cpp, isInteger.cpp, manager.asm, input_array.asm, sum.asm, atol.asm, run.sh
;   Status: Finished. The program was tested extensively with no errors in Fedora 36.
;
; This file
;    File name: sum.asm
;    Language: X86 with Intel syntax
;    Max page width: 133 columns
;    Assemble: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;
; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3


;===== Begin code area ============================================================================================================

global sum

segment .data

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

sum:

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


;Moving parameters
mov r14, rdi                   ;holds the first parameter (array)
mov r13, rsi                   ;holds the second parameter (size of array)
mov r12, 0                     ;loop counter
mov r11, 0                     ;sum
; mov rdx, 0
; cvtsi2sd xmm11, rdx            ;converting 0 to a float
;Start of the loop
loopStart:
cmp r12, r13
jge end

add r11, [r14 + r12*8]
inc r12

jmp loopStart

end:
mov rax, r11
; movsd xmm0, xmm11

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
