; write a single character to standard output.
; expects character in rax.
printchar:
    push    rdi
    push    rdx
    push    rsi
    push    rax

    mov     rax, 0x2000004
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, rsp
    syscall

    pop     rax
    pop     rsi
    pop     rdx
    pop     rdi

    ret

; write a string to standard output.
; expects string address in rax, length in rdx.
printstring:
    push    rsi
    push    rax
    push    rdi

    mov     rsi, rax
    mov     rax, 0x2000004
    mov     rdi, 1
    syscall

    pop     rdi
    pop     rax
    pop     rsi

    ret

; write an integer to standard output as ascii.
; expects the integer in rax. can do negative values.
printlong:
    push    r8
    push    rax
    push    rdx
    push    rbx
    push    rdi
    push    rsi

    xor     r8, r8

    cmp     rax, 0
    jge     dizzy
    neg     rax
    push    rax
    mov     rax, "-"
    call    printchar
    pop     rax

    dizzy:
    mov     rdx, 0
    mov     rbx, 10
    div     rbx
    add     rdx, 48
    push    rdx
    inc     r8
    cmp     rax, 0
    jz      next
    jmp     dizzy

    next:
    cmp     r8, 0
    jz      break
    dec     r8
    mov     rax, 0x2000004
    mov     rdi, 1
    mov     rdx, 1
    mov     rsi, rsp
    syscall
    add     rsp, 8
    jmp     next

    break:
    pop    rsi
    pop    rdi
    pop    rbx
    pop    rdx
    pop    rax
    pop    r8
    ret
