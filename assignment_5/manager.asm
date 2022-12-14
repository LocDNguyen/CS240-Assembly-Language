; ***************************************************************************************************************************
; Program name: "Sort Arrays". This program takes the input of an integer number and uses that as a basis for how many      *
; random float numbers should be created and passed in an array to be sorted.                                               *
; Copyright (C) 2022 Loc Nguyen.                                                                                            *
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
;   Program name: Sort Arrays
;   Programming languages: Three modules in C++, one module in C, Three modules in x86, One module in bash
;   Date program began: 2022-Nov-30
;   Date of last update: 2022-Dec-12
;   Date of reorganization of comments: 2022-Dec-12
;   Files in this program: display_array.cpp, driver.cpp, fillarray.asm, getClock.cpp, getFrequency.asm, manager.asm, sort.c, run,sh
;   Status: Finished. The program was tested extensively with no errors in Fedora 36.
;
; This file
;    File name: manager.cpp
;    Language: x86
;    Max page width: 134 columns
;    Assemble: g++ -c -m64 -Wall -o driver.o driver.cpp -fno-pie -no-pie -std=c++17
;
; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3




; //===== Begin code area ===========================================================================================================
extern printf
extern scanf
extern fillarray
extern printArray
extern fsort
extern getfreq

global manager

TITLE_LEN equ 50

segment .data

prompt db "Please input the count of number of data items to be placed into the array with (maximum 10 million): ", 0

intformat db "%ld", 0

beginningtic db "The time is now %lu tics.  Sorting will begin.", 10, 0

endingtic db "The time is now %lu tics.  Sorting has finished.", 10, 0

sortTime db "Total sort time is %lu tics which equals %.9lf seconds.", 10, 0

segment .bss

myArray resq 10000000
;arrayinput resq 50

segment .text

manager:

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



;print prompt
mov rax, 0
mov rdi, prompt
call printf



;take number input from user
sub rsp, 1024
mov rax, 0
mov rdi, intformat
mov rsi, rsp
call scanf
mov r15, [rsp]
add rsp, 1024

;fill array with inputted number
mov rax, 0
mov rdi, myArray
mov rsi, r15
call fillarray
mov r13, rax

;print the array
mov rax, 0
mov rdi, myArray
mov rsi, r13
call printArray





;get beginning tic
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r12, rdx            ;r12 stores beginning tic

;print beginningtic
mov rax, 0
mov rdi, beginningtic
mov rsi, r12
call printf





;sort array
mov rax, 0
mov rdi, myArray
mov rsi, r13
call fsort




;get ending tic
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r11, rdx

;print endingtic
mov rax, 0
mov rdi, endingtic
mov rsi, r11
call printf





;calculate speed benchmark
mov r10, r12
sub r10, r11

mov rax, 0
call getfreq
movsd xmm15, xmm0

cvtsi2sd xmm14, r12
cvtsi2sd xmm13, r11

subsd xmm14, xmm13

movsd xmm12, xmm14

divsd xmm12, xmm15

; Get value of 1 billion and store it in xmm11.
; mov rax, 0x41cdcd6500000000
; push rax
; movsd xmm11, [rsp]
; pop rax
mov r9, 1000000000000000
cvtsi2sd xmm11, r9

divsd xmm12, xmm11




;print sortTime
mov rax, 1
mov rdi, sortTime
mov rsi, r10
movsd xmm0, xmm12
call printf





;call printArray
mov rax, 0
mov rdi, myArray
mov rsi, r13
call printArray




movsd xmm10, xmm12
movsd xmm0, xmm10

;===== Restore original values to integer registers ===============================================================================
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
