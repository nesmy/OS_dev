#include "screen.h"

#define FB_GREEN		2
#define FB_DARK_GREY	8

void kmain(void)
{
	fb_write_cell(0, 'H', FB_GREEN, FB_DARK_GREY);
	fb_write_cell(2, 'E', FB_GREEN, FB_DARK_GREY);
	fb_move_cursor(3);
	fb_write_cell(4, 'L', FB_GREEN, FB_DARK_GREY);
	fb_write("HELLO", 4);
}
