#ifndef KEYBOARD_H
#define KEYBOARD_H

#include <stdbool.h>

typedef enum {
    kbd_key_none,
    kbd_key_up,
    kbd_key_left,
    kbd_key_down,
    kbd_key_right,
    kbd_key_escape,
    kbd_key_space,
    kbd_key_unknown = 0xFF,
} kbd_key;

kbd_key kbd_get_last_key(void);

#endif // KEYBOARD_H