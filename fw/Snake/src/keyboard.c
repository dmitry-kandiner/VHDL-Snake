#include <stdint.h>
#include <stdbool.h>

#include "keyboard.h"

static volatile uint32_t* const kbd_in = (void*)0x200020;

kbd_key kbd_get_last_key(void)
{
    static uint8_t prev_scancode = 0x00;
    static kbd_key key = kbd_key_none;
    uint8_t scancode = *kbd_in & 0xFF;

    if (prev_scancode == scancode) return key;
    prev_scancode = scancode;
    
    switch (scancode)
    {
        case 0xE0: break;
        case 0xF0: break;

        case 0x00: key = kbd_key_none;    break;

        case 0x29: key = kbd_key_space;   break;
        case 0x6B: key = kbd_key_left;    break;
        case 0x72: key = kbd_key_down;    break;
        case 0x74: key = kbd_key_right;   break;
        case 0x75: key = kbd_key_up;      break;
        case 0x76: key = kbd_key_escape;  break;
        default:   key = kbd_key_unknown; break;
    }

    return key;
}
