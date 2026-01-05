.text
.globl _start

_start:
    li t0, 1           # i = 1
    li t1, 10          # limit = 10
    li a0, 0           # sum = 0

loop:
    add a0, a0, t0     # sum += i
    addi t0, t0, 1     # i++
    ble t0, t1, loop   # if i <= 10, loop

    # a0 now holds 55 (1+2+...+10)