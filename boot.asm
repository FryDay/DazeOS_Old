; Constants for multiboot header.
MBALIGN     equ  1<<0
MEMINFO     equ  1<<1
FLAGS       equ  MBALIGN | MEMINFO
MAGIC       equ  0x1BADB002
CHECKSUM    equ -(MAGIC + FLAGS)

; Multiboot header.
section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

; Small temporary stack. (16MB)
section .bootstrap_stack, nobits
align 4
stack_bottom:
resb 16384
stack_top:

; Entry point for the kernel as specified in linker script.
section .text
global _start
_start:
	; Move esp register to top of stack.
	mov esp, stack_top

	; Call C entry point.
	extern kernel_main
	call kernel_main

	; If the function returns, go into an infinite loop.
	cli
.hang:
	hlt
	jmp .hang
