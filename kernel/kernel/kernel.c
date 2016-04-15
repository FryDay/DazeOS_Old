#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>

#include <kernel/tty.h>
#include <kernel/vga.h>

void kernel_init(void)
{
	terminal_initialize();
}

void kernel_main(void)
{
	printf("Welcome to ");
	terminal_setcolor(make_color(COLOR_GREEN, COLOR_BLACK));
	printf("DazeOS\n");
}
