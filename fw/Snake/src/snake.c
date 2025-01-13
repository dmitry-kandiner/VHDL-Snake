#include <stdbool.h>

#include "platform.h"

#include "screen.h"
#include "keyboard.h"

#define MAX_SNAKE_LENGTH    (64)

// typedef enum {
//     dir_up,
//     dir_right,
//     dir_down,
//     dir_left
// } direction;

typedef struct {
    uint8_t col;
    uint8_t row;
} position;

static struct {
    uint32_t level;
    uint32_t score;
    uint32_t length;
    position snake[MAX_SNAKE_LENGTH];
    // direction moving_direction;
} game = {
    0
};

static void init_level(uint32_t level);

int main()
{
    init_platform();

    init_level(game.level);
//    scr_draw_border();

    kbd_key prev_key = kbd_key_unknown;
    for(;;)
    {
        kbd_key key = kbd_get_last_key();

        if (prev_key == key) continue;
        prev_key = key;

        if (key == kbd_key_none) continue;
        
        game.level++;
        init_level(game.level);
    }

    cleanup_platform();
    return 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////
#define MAX_LEVELS      (5)
static void init_level(uint32_t level)
{
    scr_clear();
    scr_print_score(game.score);
    scr_print_level(game.level + 1);
    scr_draw_border();
    switch (level % MAX_LEVELS)
    {
        case 0:
            break;
        case 1:
            for (uint32_t col = 14; col < 25; col++)
            {
                scr_putch(col, 14, scr_wall);
            }
            break;
        case 2:
            for (uint32_t row = 10; row < 19; row++)
            {
                scr_putch(14, row, scr_wall);
                scr_putch(24, row, scr_wall);
            }
            break;
        case 3:
            for (uint32_t row = 10; row < 19; row++)
            {
                scr_putch(14, row, scr_wall);
                scr_putch(24, row, scr_wall);
            }
            for (uint32_t col = 15; col < 24; col++)
            {
                scr_putch(col, 14, scr_wall);
            }
            break;
        case 4:
            for (uint32_t row = 10; row < 13; row++)
            {
                scr_putch(14, row, scr_wall);
                scr_putch(24, row, scr_wall);
            }
            for (uint32_t row = 16; row < 19; row++)
            {
                scr_putch(14, row, scr_wall);
                scr_putch(24, row, scr_wall);
            }
            for (uint32_t col = 15; col < 24; col++)
            {
                scr_putch(col, 10, scr_wall);
                scr_putch(col, 18, scr_wall);
            }
            break;
    }
}
