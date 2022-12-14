; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
;
; Author information
;   Author name: Loc Nguyen
;   Author email: lnguy121@csu.fullerton.edu
;   Date: October 12, 2022
;   Section ID: Section MW 12-2pm
;
; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3


;===== Begin code area ============================================================================================================
extern printf
extern scanf
extern isfloat
extern atof

global inputs

segment .data
one_string_format db "%s", 0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

inputs:

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

;Start of the loop
loopStart:
sub rsp, 1024
mov rax, 0
mov rdi, one_string_format           ;%s
mov rsi, rsp
call scanf


;Checks for ctrl-D
cdqe
cmp rax, -1
je pressed

;Validation
mov rax, 0
mov rdi, rsp
call isfloat                  ;checks user input, if integer return 1, else return 0
cmp rax, 0
je error

;Conversion
mov rax, 0
mov rdi, rsp
call atof                        ;turns string input into a number
movsd xmm8, xmm0                 ;stores number into r11

;Moving into array
movsd [r14 + r12*8], xmm8        ;stores stored number in r11 into array, r14
inc r12                       ;increments r12 to move to next array index
add rsp, 1024

cmp r12, r13                   ;compares current counter to size of array
je tooMuch

jmp loopStart

error:
add rsp, 1024
jmp loopStart

pressed:
add rsp, 1024

end:
mov rax, r12
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
