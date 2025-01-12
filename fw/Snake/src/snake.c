#include <stdbool.h>

#include "platform.h"

#include "screen.h"
#include "keyboard.h"

// void scr_put_hex(uint32_t col, uint32_t row, uint32_t value)
// {
//     static const char hex[16] = "0123456789ABCDEF";
//     scr_putch(col + 0, row, hex[(value >> 28) & 0x0F]);
//     scr_putch(col + 1, row, hex[(value >> 24) & 0x0F]);
//     scr_putch(col + 2, row, hex[(value >> 20) & 0x0F]);
//     scr_putch(col + 3, row, hex[(value >> 16) & 0x0F]);
//     scr_putch(col + 4, row, hex[(value >> 12) & 0x0F]);
//     scr_putch(col + 5, row, hex[(value >>  8) & 0x0F]);
//     scr_putch(col + 6, row, hex[(value >>  4) & 0x0F]);
//     scr_putch(col + 7, row, hex[(value >>  0) & 0x0F]);
// }

void scr_put_hex(uint32_t col, uint32_t row, uint8_t value)
{
    static const char hex[16] = "0123456789ABCDEF";
    scr_putch(col + 0, row, hex[(value >> 4) & 0x0F]);
    scr_putch(col + 1, row, hex[(value >> 0) & 0x0F]);
}

int main()
{
    init_platform();

    scr_clear();
    scr_print_score(275);
    scr_print_level(1);
    scr_draw_border();

    kbd_key prev_key = kbd_key_none;
    int i = 0;
    for(;;)
    {
        kbd_key key = kbd_get_last_key();

        if (prev_key == key) continue;
        prev_key = key;

        scr_put_hex(i, 1, key);
        i += 2;
        // char* key_name;
        // switch (key)
        // {
        //     case kbd_key_up:     key_name = "up arrow   "; break;
        //     case kbd_key_right:  key_name = "right arrow"; break;
        //     case kbd_key_down:   key_name = "down arrow "; break;
        //     case kbd_key_left:   key_name = "left arrow "; break;
        //     case kbd_key_space:  key_name = "space bar  "; break;
        //     case kbd_key_escape: key_name = "escape     "; break;
        //     default:             key_name = "unknown key"; break;
        // }

        // scr_puts(1, 2, key_name);
    }

    cleanup_platform();
    return 0;
}
