#include <stdint.h>

#include "keyboard.h"

static volatile uint32_t* const kbd_in = (void*)0x200020;

kbd_key kbd_get_last_key(void)
{
    switch (*kbd_in & 0x000000FF)
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
