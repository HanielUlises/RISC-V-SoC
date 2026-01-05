.text
.globl _start

_start:
    li t0, 42          # value = 42
    la t1, data        # address of data
    sd t0, 0(t1)       # store doubleword (64-bit) to memory
    ld a0, 0(t1)       # load back into a0 (a0 = 42)

.data
data:
    .dword 0           # reserve 64-bit space initialized to 0