#include <stdint.h>
#include <stdbool.h>

#include "keyboard.h"

typedef enum {
    kbd_st_idle,
    kbd_st_extended,
    kbd_st_key_pressed,
    kbd_st_releasing
} kbd_state;

static volatile uint32_t* const kbd_in = (void*)0x200020;

static kbd_key kbd_decode(uint8_t scancode);

kbd_key kbd_get_last_key(void)
{
    static kbd_state state = kbd_st_idle;
    static uint8_t prev_scancode = 0x00;
    static kbd_key key = kbd_key_none;
    uint8_t scancode = *kbd_in & 0xFF;


    if (prev_scancode == scancode) return key;
    prev_scancode = scancode;

    switch (state)
    {
        case kbd_st_idle:
            if (scancode == 0xE0) state = kbd_st_extended;
            else
            {
                key = kbd_decode(scancode);
                state = kbd_st_key_pressed;
            }
            break;
        case kbd_st_extended:
            key = kbd_decode(scancode);
            state = kbd_st_key_pressed;
            break;
        case kbd_st_key_pressed:
            if (scancode == 0xF0) state = kbd_st_releasing;
            break;
        case kbd_st_releasing:
            key = kbd_key_none;
            state = kbd_st_idle;
            break;
    }

    return key;
}

static kbd_key kbd_decode(uint8_t scancode)
{
    switch (scancode)
    {
        case 0x29: return kbd_key_space;
        case 0x6B: return kbd_key_left;
        case 0x72: return kbd_key_down;
        case 0x74: return kbd_key_right;
        case 0x75: return kbd_key_up;
        case 0x76: return kbd_key_escape;
        default:   return kbd_key_unknown;
    }
}
