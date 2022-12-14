;=====================================================================================================================================
;  Name: Loc Nguyen
;  Email: locdacnguyen0@gmail.com
;	This course number, namely “CPSC240-1”.
;	The words: “Final Program Test”.
;======================================================================================================================================


extern scanf
extern printf

global harmonicsum

section .data
  int_format db "%ld", 10, 0
  text2 db "in hmean %0.9lf", 10, 0

section .bss

section .text

harmonicsum:
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

  mov r14, rdi    ;array
  mov r13, rsi    ;count
  mov r12, 0      ;index


  ; 1 from 1/n
  mov rax, 0x3ff0000000000000
  movq xmm15, rax

  ; xmm10 = 0.0
  xorpd xmm10, xmm10
  start_loop:

  cmp r12, r13
  je hmean

  movsd xmm14, [r14+ r12*8]

  ; divide 1/current n; add to total
  movsd xmm13, xmm15
  divsd xmm13, xmm14
  addsd xmm10, xmm13

  xorpd xmm14,xmm14
  inc r12

  jmp start_loop


hmean:
  cvtsi2sd xmm11, r13
  divsd xmm11, xmm10

end_pops:

  ; Mov sum into xmm0 to return.
  movsd xmm1, xmm11
  movsd xmm0, xmm10

  ; pop registers.
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
