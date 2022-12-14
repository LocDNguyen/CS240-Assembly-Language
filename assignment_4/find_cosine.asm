;****************************************************************************************************************************
; THIS PROGRAM DOES NOT HAVE INPUT VALIDATION                                                                               *
;                                                                                                                           *
; Program name: "Find cosine". This program takes a float input and converts it to it's radian counterpart as well as       *
; outputs the time in ticks. Then the program finds the cosine of the float input then displays the ticks again.            *
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
;   Program name: Find cosine
;   Programming languages: 6 modules in X86, and one module in bash
;   Date program began: 2022-Oct-24
;   Date of last update: 2022-Oct-29
;   Date of reorganization of comments: 2022-Oct-29
;   Files in this program: find_cosine.asm, atof.asm, cosine.asm, ftoa.asm, itoa.asm, strlen.asm, run.sh
;   Status: Finished. The program was tested extensively with no errors in Fedora 36.
;
; This file
;    File name: find_cosine.asm
;    Language: X86 with Intel syntax
;    Max page width: 133 columns
;    Assemble: nasm -f elf64 -l find_cosine.lis -o find_cosine.o find_cosine.asm
;
; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3

;===== Begin main assembly program here ================================================================================
;All correctly formed program structures have one entry point and one exit point.
;Below is the declaration of the entry point to this program
global _start                                               ;The global declaration is required by the linker.

;Declare library functions
extern itoa
extern strlen
extern atof
extern ftoa
extern cosine

;Data destinations (constants without data size specified)
Stdin  equ 0
Stdout equ 1
Stderror equ 2

;Kernel function code numbers
system_read  equ 0
system_write equ 1        ;Kernel function
system_terminate equ 60   ;Kernel function
;System_time equ 201       :Kernel function "get_time" not used in this program

;Named constants
Null equ 0
Exit_with_success equ 0
Line_feed equ 10
Numeric_string_array_size equ 32



section .data

welcome db "Welcome to Accurate Cosines by Loc Nguyen.", 10, 10, 0

time_now db "The time is now ", Null

tics db " tics.", 10, Null

seconds db " seconds.", 10, Null

caution db "Be aware that there is no input validation in this program.", 10, 0

prompt db "Please enter an angle in degrees and press enter: ", Null

confirmation db "You entered ", Null

in_radians db "The equivalent radians is ", Null

in_cosine db "The cosine of those degrees is ", Null

newline db 0xa, Null

bye db "Have a nice day. Bye.", 0



section .bss

first_tic resb Numeric_string_array_size

second_tic resb Numeric_string_array_size

input_integer_string resb Numeric_string_array_size

output_string resb Numeric_string_array_size

radian_string resb Numeric_string_array_size

cosine_string resb Numeric_string_array_size



section .text                   ;The executable area begins here.
_start:                         ;Main entry point.  Execution begins here.  The name must be _start.

;There is no backup of registers because there is not caller.  We only backup registers to protect the data belonging to the caller.




;Output a newline
mov byte [newline],0xa
mov byte [newline+1],Null
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline
mov    rdx, 1               ;Number of newlines to be written
syscall




;////////////////////////////////////////////////////////Welcome////////////////////////////////////////////////////
;Obtain the length of the welcome string
mov        rax, 0
mov        rdi, welcome
call       strlen
mov        r12, rax            ;r12 holds length of the welcome string

;Output the welcome message
mov        rax, system_write
mov        rdi, Stdout
mov        rsi, welcome
mov        rdx, r12            ;Number of bytes to be written.
syscall
;////////////////////////////////////////////////////////Welcome////////////////////////////////////////////////////




;////////////////////////////////////////////////////////Tics////////////////////////////////////////////////////
;Obtain the length of the time_now string
mov        rax, 0
mov        rdi, time_now
call       strlen
mov        r12, rax            ;r12 holds number of bytes in the string instruction

;Output the time_now string
mov        rax, system_write
mov        rdi, Stdout
mov        rsi, time_now
mov        rdx, r12            ;Number of bytes to be written.
syscall

;Get the time
cpuid
rdtsc
shl rdx, 32
or rdx, rax
mov r8, rdx

mov rax, 0
mov rdi, r8
mov rsi, first_tic
call itoa
mov r15, first_tic     ;r15 holds the string representation of the square of the input number

;Get length of tic
mov    rax, 0
mov    rdi, r15
call   strlen
mov    r12, rax
;Output the tic
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, r15
mov    rdx, r12             ;Number of bytes to be written.
syscall

;Obtain the length of the tics string
mov        rax, 0
mov        rdi, tics
call       strlen
mov        r12, rax            ;r12 holds number of bytes in the string instruction

;Output the tics string
mov        rax, system_write
mov        rdi, Stdout
mov        rsi, tics
mov        rdx, r12            ;Number of bytes to be written.
syscall
;////////////////////////////////////////////////////////Tics////////////////////////////////////////////////////




;Output a newline
mov byte [newline],0xa
mov byte [newline+1],Null
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline
mov    rdx, 1               ;Number of newlines to be written
syscall




;////////////////////////////////////////////////////////Prompt////////////////////////////////////////////////////
;Obtain the length of the prompt string
mov        rax, 0
mov        rdi, prompt
call       strlen
mov        r12, rax            ;r12 holds length of the prompt string

;Output the prompt for the an integer
mov        rax, system_write
mov        rdi, Stdout
mov        rsi, prompt
mov        rdx, r12              ;Number of bytes to be written.
syscall

;Strategy based on Jorgensen, Chapter 13
;Input char from keyboard one byte at a time.

;Preloop initialization
mov rbx, input_integer_string
mov r12,0       ;r12 is counter of number of bytes inputted
push qword 0    ;Storage for incoming byte

Begin_loop:         ;This is the one point of entry into the loop structure.
mov    rax, system_read
mov    rdi, Stdin
mov    rsi, rsp
mov    rdx, 1    ;one byte will be read from the input buffer
syscall

mov al, byte [rsp]

cmp al, Line_feed
je Exit_loop     ;If EOL is encountered then discard EOL and exit the loop.
              ;This is the only point in the loop structure where exit is allowed.

inc r12          ;Count the number of bytes placed into the array.

;Check that the destination array has not overflowed.
cmp r12,Numeric_string_array_size
;if(r12 >= Input_array_size)
   jge end_if_else
;else (r12 < Numeric_string_array_size)
    mov byte [rbx],al
    inc rbx
end_if_else:

jmp Begin_loop

Exit_loop:
;The algorithm implemented above allows upto (Numeric_string_array_size - 1) bytes to be entered into the
;destination array, thereby, reserving one byte for the null character.  However, if the user does
;enter more than (Numeric_string_array_size - 1) bytes of data then the excess bytes are read and discarded.
;The algorithm was adapted from Jorgensen, Chapter 13, Section 13.4.1
mov byte [rbx],Null        ;Append the null character.

pop rax          ;Return the stack to its former state.
;input_integer_string holds the user input.  However, if the user inputted more than (Numeric_string_array_size - 1)
;bytes then the excess will be discarded.  The last byte in the array is reserved for the null char.
;////////////////////////////////////////////////////////Prompt////////////////////////////////////////////////////




;Output a newline
mov byte [newline],0xa
mov byte [newline+1],Null
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline
mov    rdx, 1               ;Number of newlines to be written
syscall




;////////////////////////////////////////////////////////Confirmation////////////////////////////////////////////////////
;Obtain the length of the confirmation message
mov rax, 0
mov rdi, confirmation
call strlen
mov r12, rax
;Write the value that was recently entered.
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, confirmation    ;"You entered "
mov    rdx, r12             ;Number of bytes to be written.
syscall

;Obtain the length of string holding the inputted number
mov    rax, 0
mov    rdi, input_integer_string
call   strlen
mov    r12, rax
;Output the number
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, input_integer_string
mov    rdx, r12             ;Number of bytes to be written.
syscall
;////////////////////////////////////////////////////////Confirmation////////////////////////////////////////////////////




;Output a newline
mov byte [newline],0xa
mov byte [newline+1],Null
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline
mov    rdx, 1               ;Number of newlines to be written
syscall

;Output a newline
mov byte [newline],0xa
mov byte [newline+1],Null
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline
mov    rdx, 1               ;Number of newlines to be written
syscall




;////////////////////////////////////////////////////////Radian////////////////////////////////////////////////////
;Output the square stored as string to the console
;Compute the length of the descriptive message
mov rax, 0
mov rdi, in_radians           ;"The equivalent in radians is  "
call strlen
mov r9, rax

;Output descriptive message
mov rax, system_write
mov rdi, Stdout
mov rsi, in_radians           ;"The square of the inputted integer is ",0
mov rdx, r9
syscall

mov rax, 0
mov rdi, input_integer_string
call atof
movsd xmm8, xmm0

;get radian value
mov rbx, 180
cvtsi2sd xmm10, rbx
mov rax, 0x400921FB54442D18
push rax
movsd xmm9, [rsp]
pop rax

mulsd xmm8, xmm9
divsd xmm8, xmm10

;call ftoa to get radian value
mov rax, 1
movsd xmm0, xmm8
mov rdi, radian_string
call ftoa
mov r12, rax

;output radian value
mov rax, system_write
mov rdi, Stdout
mov rsi, radian_string
mov rdx, r9
syscall
;////////////////////////////////////////////////////////Radian////////////////////////////////////////////////////




;Output a newline
mov byte [newline],0xa
mov byte [newline+1],Null
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline
mov    rdx, 1               ;Number of newlines to be written
syscall

;Output a newline
mov    byte [newline],0xa        ;<==Insurance: assure that newline points to the new line character
mov    byte [newline+1],Null     ;<==Terminate with the null character.
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline       ;<==newline has changed
mov    rdx, 1             ;Number of bytes to be written
syscall




;////////////////////////////////////////////////////////Cosine////////////////////////////////////////////////////
;call cosine
mov rax, 1
movsd xmm0, xmm8
call cosine
movsd xmm9, xmm0

;get strlen of cosine_prompt
mov rax, 0
mov rdi, in_cosine
call strlen
mov r15, rax

;output cosine_prompt
mov rax, system_write
mov rdi, Stdout
mov rsi, in_cosine
mov rdx, r15
syscall

; call ftoa
mov rax, 1
movsd xmm0, xmm9
mov rdi, cosine_string
call ftoa
mov r12, rax

;output float_string
mov rax, system_write
mov rdi, Stdout
mov rsi, cosine_string
mov rdx, r12
syscall
;////////////////////////////////////////////////////////Cosine////////////////////////////////////////////////////




;Output a newline
mov byte [newline],0xa
mov byte [newline+1],Null
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline
mov    rdx, 1               ;Number of newlines to be written
syscall

;Output a newline
mov    byte [newline],0xa        ;<==Insurance: assure that newline points to the new line character
mov    byte [newline+1],Null     ;<==Terminate with the null character.
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline       ;<==newline has changed
mov    rdx, 1             ;Number of bytes to be written
syscall




;////////////////////////////////////////////////////////Tics////////////////////////////////////////////////////
;Obtain the length of the time_now string
mov        rax, 0
mov        rdi, time_now
call       strlen
mov        r12, rax            ;r12 holds number of bytes in the string instruction

;Output the time_now string
mov        rax, system_write
mov        rdi, Stdout
mov        rsi, time_now
mov        rdx, r12            ;Number of bytes to be written.
syscall

;Get the time
cpuid
rdtsc
shl rdx, 32
or rdx, rax
mov r14, rdx

mov rax, 0
mov rdi, r14
mov rsi, second_tic
call itoa
mov r15, second_tic     ;r15 holds the string representation of the square of the input number

;Get length of tic
mov    rax, 0
mov    rdi, r15
call   strlen
mov    r12, rax
;Output the tic
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, r15
mov    rdx, r12             ;Number of bytes to be written.
syscall

;Obtain the length of the seconds string
mov        rax, 0
mov        rdi, seconds
call       strlen
mov        r12, rax            ;r12 holds number of bytes in the string instruction

;Output the seoncds string
mov        rax, system_write
mov        rdi, Stdout
mov        rsi, seconds
mov        rdx, r12            ;Number of bytes to be written.
syscall
;////////////////////////////////////////////////////////Tics////////////////////////////////////////////////////




;Output a newline
mov    byte [newline],0xa        ;<==Insurance: assure that newline points to the new line character
mov    byte [newline+1],Null     ;<==Terminate with the null character.
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline       ;<==newline has changed
mov    rdx, 1             ;Number of bytes to be written
syscall




;////////////////////////////////////////////////////////End////////////////////////////////////////////////////
;Output the final message
;Obtain the length of the final message
mov    rax, 0
mov    rdi, bye
call   strlen
mov    r12, rax           ;r12 holds length of the final message

;Output the final message
mov rax, system_write
mov rdi, Stdout
mov rsi, bye              ;bye is pointer to the string to be outputted to stdout
mov rdx, r12
syscall
;////////////////////////////////////////////////////////End////////////////////////////////////////////////////




;Output a newline
mov    byte [newline],0xa        ;<==Insurance: assure that newline points to the new line character
mov    byte [newline+1],Null     ;<==Terminate with the null character.
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline       ;<==newline has changed
mov    rdx, 1             ;Number of bytes to be written
syscall

;Output a newline
mov    byte [newline],0xa       ;<==Insurance: assure that newline points to the new line character
mov    byte [newline+1],Null    ;<==Terminate with the null character.
mov    rax, system_write
mov    rdi, Stdout
mov    rsi, newline       ;<==newline has changed
mov    rdx, 1             ;Number of bytes to be written
syscall




;Epilogue =====Now exit from this program and return control to the OS =================================================
mov    rax, system_terminate        ;60 is the number of the kernelfunction that terminates an executing program.
mov    rdi, Exit_with_success       ;0 is the error code number for success, that will be returned to the OS.
syscall
;We cannot use an ordinary ret instruction here because this program was not called by some other module.
;The program does not know where to return to.

;===== End of program _start ===========================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2
