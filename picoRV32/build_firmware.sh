#!/bin/bash

set -e
cd firmware

echo "Compiling assembly..."
riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32i -o code.o code.S

echo "Linking and generating ELF..."
riscv64-unknown-elf-gcc -Og -mabi=ilp32 -march=rv32i -ffreestanding -nostdlib \
    -Wl,--build-id=none,-Bstatic,-T,sections.lds,-Map,code.map,--strip-debug \
    code.o -lgcc -o code.elf

echo "Build successful: code.elf created."