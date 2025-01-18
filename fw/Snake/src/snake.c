#include <stdbool.h>
#include <stdlib.h>
#include <memory.h>
#include <time.h>

#include "platform.h"

#include "screen.h"
#include "keyboard.h"

#define MAX_SNAKE_LENGTH    (64)

typedef enum {
    dir_up,
    dir_right,
    dir_down,
    dir_left
} direction;

static struct {
    uint32_t level;
    uint32_t score;
    struct {
        uint32_t length;
        char     body[MAX_SNAKE_LENGTH];
        uint32_t head_col;
        uint32_t head_row;
    } snake;
    uint32_t prize_col;
    uint32_t prize_row;
} game = {
    0
};

static void init_level(uint32_t level);
static void draw_snake(void);
static void place_prize(void);

int main()
{
    init_platform();

    srand(time(0));

    init_level(game.level);

    kbd_key prev_key = kbd_key_unknown;
    for(;;)
    {
        kbd_key key = kbd_get_last_key();

        if (prev_key == key) continue;
        prev_key = key;

        if (key == kbd_key_none) continue;

        place_prize();

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
    static const char snake[] = { scr_head_left, scr_body_horz, scr_body_horz, scr_body_horz, scr_body_horz, scr_tail_right };
    // static const char snake[] = {
    //     scr_head_left, scr_body_horz, scr_body_horz, scr_corner_ur, scr_body_vert,
    //     scr_body_vert, scr_corner_bl, scr_body_horz, scr_body_horz, scr_corner_br,
    //     scr_body_vert, scr_body_vert, scr_body_vert, scr_corner_ur, scr_body_horz, 
    //     scr_corner_ul, scr_corner_bl, scr_corner_ur, scr_corner_br, scr_tail_left };

    memcpy(game.snake.body, snake, sizeof(snake));
    game.snake.length = sizeof(snake);
    game.snake.head_col = 17;
    game.snake.head_row = 6;

    scr_clear();
    scr_print_score(game.score);
    scr_print_level(game.level + 1);
    scr_draw_border();
    switch (level % MAX_LEVELS)
    {
        case 0:
            break;
        case 1:
            for (uint32_t col = 14; col < 26; col++)
            {
                scr_putch(col, 15, scr_wall);
            }
            break;
        case 2:
            for (uint32_t row = 11; row < 20; row++)
            {
                scr_putch(14, row, scr_wall);
                scr_putch(25, row, scr_wall);
            }
            break;
        case 3:
            for (uint32_t row = 11; row < 20; row++)
            {
                scr_putch(14, row, scr_wall);
                scr_putch(25, row, scr_wall);
            }
            for (uint32_t col = 15; col < 25; col++)
            {
                scr_putch(col, 15, scr_wall);
            }
            break;
        case 4:
            for (uint32_t row = 11; row < 14; row++)
            {
                scr_putch(14, row, scr_wall);
                scr_putch(25, row, scr_wall);
            }
            for (uint32_t row = 17; row < 20; row++)
            {
                scr_putch(14, row, scr_wall);
                scr_putch(25, row, scr_wall);
            }
            for (uint32_t col = 15; col < 25; col++)
            {
                scr_putch(col, 11, scr_wall);
                scr_putch(col, 19, scr_wall);
            }
            break;
    }
    draw_snake();
}

static void draw_snake(void)
{
    uint32_t col = game.snake.head_col;
    uint32_t row = game.snake.head_row;
    direction dir;

    for (uint32_t i = 0; i < game.snake.length; i++)
    {
        scr_putch(col, row, game.snake.body[i]);
        switch (game.snake.body[i])
        {
            case scr_head_up:    dir = dir_down;  break;
            case scr_head_right: dir = dir_left;  break;
            case scr_head_down:  dir = dir_up;    break;
            case scr_head_left:  dir = dir_right; break;
            case scr_corner_ul:  dir = (dir == dir_left)  ? dir_down : dir_right; break;
            case scr_corner_ur:  dir = (dir == dir_right) ? dir_down : dir_left;  break;
            case scr_corner_bl:  dir = (dir == dir_left)  ? dir_up   : dir_right; break;
            case scr_corner_br:  dir = (dir == dir_right) ? dir_up   : dir_left;  break;
        }
        switch (dir)
        {
            case dir_up:    row--; break;
            case dir_right: col++; break;
            case dir_down:  row++; break;
            case dir_left:  col--; break;
        }
    }
}

static void place_prize(void)
{
    uint32_t col;
    uint32_t row;
    do {
        col = 1 + rand() % (SCR_COLS - 2);
        row = 2 + rand() % (SCR_ROWS - 3);
    } while (!scr_is_empty(col, row));
    game.prize_col = col;
    game.prize_row = row;
}
