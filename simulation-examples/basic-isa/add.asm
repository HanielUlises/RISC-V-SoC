.text
.globl _start

_start:
    li a0, 10          # Load immediate: a0 = 10
    li a1, 20          # a1 = 20
    add a2, a0, a1     # a2 = a0 + a1 (30)
    sub a3, a1, a0     # a3 = a1 - a0 (10)
    # Program ends (in simulators like RARS, use ecall to exit if needed)