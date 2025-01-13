#include <stdbool.h>

#include "platform.h"

#include "screen.h"
#include "keyboard.h"

int main()
{
    init_platform();

    scr_clear();
    scr_print_score(275);
    scr_print_level(1);
    scr_draw_border();

    kbd_key prev_key = kbd_key_none;
    for(;;)
    {
        kbd_key key = kbd_get_last_key();

        if (prev_key == key) continue;
        prev_key = key;

        char* key_name;
        switch (key)
        {
            case kbd_key_none:    key_name = "           "; break;
            case kbd_key_up:      key_name = "up arrow   "; break;
            case kbd_key_right:   key_name = "right arrow"; break;
            case kbd_key_down:    key_name = "down arrow "; break;
            case kbd_key_left:    key_name = "left arrow "; break;
            case kbd_key_space:   key_name = "space bar  "; break;
            case kbd_key_escape:  key_name = "escape     "; break;
            case kbd_key_unknown: key_name = "unknown key"; break;
        }

        scr_puts(1, 2, key_name);
    }

    cleanup_platform();
    return 0;
}
