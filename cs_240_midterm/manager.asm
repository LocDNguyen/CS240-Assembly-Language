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
extern fgets
extern stdin
extern strchr

extern max
extern inputs
extern Display

arraysize equ 6

global start

segment .data
inputprompt db "Please enter your name: ", 0
inputprompt3 db "Please enter floating point numbers separated by ws to be stored in an array of size 6 cells.", 10, 0
inputprompt4 db "After the last input press <enter> followed by <control+D>.", 10, 0
inputprompt5 db 10, "These numbers are stored in the array", 10, 0
amount db 10, "The largest value in the array is %.10lf", 10, 10, 0
one_string_format db "%s", 0
two_float_format db "%lf %lf", 0


segment .bss  ;Reserved for uninitialized data
name resb 64
array resq 6

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


;Prompt user
mov rax, 0
mov rdi, inputprompt                         ;"Please enter your name: '
call printf

;Taking name input
mov rax, 0
mov rdi, name                               ;"%s"
mov rsi, 32
mov rdx, [stdin]
call fgets

mov rax, 0
mov rdi, name
mov rsi, 10
call strchr
mov byte [rax], 0

mov rax, 0
mov rdi, inputprompt3                         ;"Please enter floating point numbers separated by ws to be stored in an array of size 6 cells."
call printf

mov rax, 0
mov rdi, inputprompt4                         ;"After the last input press <enter> followed by <control+D>."
call printf

;Taking string inputs
mov rax, 0
mov rdi, array
mov rsi, arraysize
call inputs
mov r12, rax

;Print array
mov rax, 0
mov rdi, inputprompt5
call printf

;Print elements in the array
mov rax, 0
mov rdi, array
mov rsi, r12
call Display

;Adding inputs
mov rax, 0
mov rdi, array
mov rsi, r12
call max
movsd xmm10, xmm0

;Print total number of inputs and sum
mov rax, 1
mov rdi, amount
movsd xmm0, xmm10
call printf

;Finish execution
mov rax, name
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
