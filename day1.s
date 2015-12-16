global start

section .text

%include "aoclib.s"

start:
    xor     r8, r8
    xor     r9, r9
    xor     r10, r10

count:
    inc     r9

    mov     rax, 0x2000003
    mov     rdi, 0
    lea     rsi, [rsp-8]
    mov     rdx, 1
    syscall

    cmp     rax, 0
    je      exit

    cmp     byte [rsi], "("
    je      up

    cmp     byte [rsi], ")"
    je      down

    cmp     byte [rsi], 10
    je      exit

zoinks:
    cmp     r8, -1
    je      scoobs
    jmp     count

scoobs:
    cmp     r10, 0
    je      scrappy
    jmp     count

scrappy:
    mov     r10, r9
    jmp     count

up:
    inc     r8
    jmp     zoinks

down:
    dec     r8
    jmp     zoinks

exit:
    mov     rax, one
    mov     rdx, one.len
    call    printstring

    mov     rax, r8
    call    printlong

    mov     rax, two
    mov     rdx, two.len
    call    printstring

    mov     rax, r10
    call    printlong

    mov     rax, 10
    call    printchar

    mov     rax, 0x2000001
    mov     rdi, 0
    syscall

section .data
one  db  "Instructions take Santa to floor: "
.len equ $ - one
two  db  10, "First entering the basement at position: "
.len equ $ - two
