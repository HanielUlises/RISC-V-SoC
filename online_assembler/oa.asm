.global _boot
.text

_boot:
    addi x1, x0, 1000
    addi x2, x1, 2000
    addi x3, x2, -1000
    addi x4, x3, -2000
    addi x5, x4, 1000

    la x6, variable
    addi x6, x6, 4

.data 
variable:
    .word 0xdeadbeef
variable2:
    .word 0x12341234

/* Declared but not initialized */
.bss
un_init_var:
    .word 0x00
