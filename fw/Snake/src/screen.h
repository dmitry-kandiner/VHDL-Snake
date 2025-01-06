#ifndef SCREEN_H
#define SCREEN_H

#include <stdint.h>

#define SCR_ROWS        (30)
#define SCR_COLS        (40)

typedef enum {
    scr_wall       = 0x01,
    scr_prize      = 0x02,
    scr_head_left  = 0x04,
    scr_head_up    = 0x05,
    scr_head_right = 0x06,
    scr_head_down  = 0x07,
    scr_tail_left  = 0x08,
    scr_tail_up    = 0x09,
    scr_tail_right = 0x0A,
    scr_tail_down  = 0x0B,
    scr_corner_ul  = 0x0C,
    scr_corner_ur  = 0x0D,
    scr_corner_bl  = 0x0E,
    scr_corner_br  = 0x0F,
    scr_body_horz  = 0x10,
    scr_body_vert  = 0x11
} scr_special;

void scr_clear(void);
void scr_putch(uint32_t col, uint32_t row, char ch);
void scr_puts(uint32_t col, uint32_t row, const char* const str);

void scr_draw_border(void);
void scr_draw_score(uint32_t score);

#endif // SCREEN_H