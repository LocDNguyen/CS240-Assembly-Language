;=====================================================================================================================================
;  Name: Loc Nguyen
;  Email: locdacnguyen0@gmail.com
;	This course number, namely “CPSC240-1”.
;	The words: “Final Program Test”.
;======================================================================================================================================




; //===== Begin code area ===========================================================================================================
extern printf
extern scanf
extern random_fill_array
extern printArray
extern harmonicsum

global supervisor

TITLE_LEN equ 50

segment .data

prompt db "Please input the count of number of data items to be placed into the array with (maximum 1 million): ", 0

prompt_two db 10, "The array has been filled with non-deterministic random 64-bit float numbers.", 10, 0

hsum db "The harmonic sum is %1.180lf", 10, 10, 0

hmean db "The harmonic mean is %1.180lf", 10, 10, 0

end db "The supervisor will return the mean to the caller.", 10, 10, 0

intformat db "%ld", 0
floatformat db "%1.180lf", 0

segment .bss

myArray resq 1000000

segment .text

supervisor:

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
call random_fill_array
mov r13, rax

;print prompt_two
mov rax, 0
mov rdi, prompt_two
call printf

;print the array
mov rax, 0
mov rdi, myArray
mov rsi, r13
call printArray


;get harmonicsum
mov rax, 0
mov rdi, myArray
mov rsi, r13
call harmonicsum
movsd xmm12, xmm0
movsd xmm11, xmm1

mov rax, 1
mov rdi, hsum
movsd xmm0, xmm12
call printf

mov rax, 1
mov rdi, hmean
movsd xmm0, xmm11
call printf




;end
mov rax, 0
mov rdi, end
call printf

;Return mean
movsd xmm0, xmm11

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
