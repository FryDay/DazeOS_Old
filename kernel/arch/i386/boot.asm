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

; Small temporary stack. (16 KiB)
section .bootstrap_stack, nobits
align 4
stack_bottom:
resb 16384
stack_top:

; The kernel entry point.
section .text
global _start
_start:
	; Enter protected mode.
	mov eax, cr0
	or eax, 1
	mov cr0, eax

	mov esp, stack_top

	; Initialize the kernel.
	extern kernel_init
	call kernel_init

	; Call the global constructors.
	extern _init
	call _init

	; Transfer control to the kernel.
	extern kernel_main
	call kernel_main

	; Hang if kernel_main unexpectedly returns.
	cli
.hang:
	hlt
	jmp .hang
