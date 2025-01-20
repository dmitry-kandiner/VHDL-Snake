#include <stdbool.h>
#include <stdlib.h>
#include <time.h>

#include "platform.h"

#include "main.h"
#include "screen.h"
#include "keyboard.h"
#include "snake.h"

#define BASIC_LEVELS            (5)

#define PRIZES_FOR_LEVEL_UP     (15)

#define SNAKE_STAR_COL  (17)
#define SNAKE_STAR_ROW  (6)

typedef enum {
    st_init,
    st_wait_for_start,
    st_playing,
    st_pause,
    st_game_over,
    st_exit
} state_t;

static struct {
    state_t  state;
    uint32_t level;
    uint32_t score;
    position_t snake_head;
    direction_t snake_dir;
    position_t prize;
    uint32_t prizes_collected;
} game = {
    .state = st_init,
};

static void display_logo(void);
static void display_level_up(void);
static void display_pause(void);
static void display_level(uint32_t level);
static void setup_snake(void);
static void setup_prize(void);
static void display_prize(void);
static void process_game(void);
static uint32_t get_prize_cost(void);
static uint32_t get_growth_rate(void);

int main()
{
    init_platform();

    srand(0);
    
    while (game.state != st_exit)
    {
        usleep(250000);        
        switch (game.state)
        {
            case st_init:
                game.score = 0;
                game.level = 0;
                display_logo();
                game.state = st_wait_for_start;
                break;

            case st_wait_for_start:
                if (kbd_get_last_key() == kbd_key_none) break;
                game.prizes_collected = 0;
                display_level(game.level);
                setup_snake();
                snake_display(game.snake_head);
                setup_prize();
                display_prize();
                game.state = st_playing;
                break;

            case st_playing:
                switch (kbd_get_last_key())
                {
                    case kbd_key_escape:
                        display_pause();
                        game.state = st_pause;
                        continue;

                    case kbd_key_up:    game.snake_dir = dir_up;    break;
                    case kbd_key_right: game.snake_dir = dir_right; break;
                    case kbd_key_down:  game.snake_dir = dir_down;  break;
                    case kbd_key_left:  game.snake_dir = dir_left;  break;

                    default: break;
                }
                process_game();
                break;

            case st_pause:
                if (kbd_get_last_key() == kbd_key_none) break;
                display_level(game.level);
                snake_display(game.snake_head);
                display_prize();
                game.state = st_playing;
                break;

            case st_game_over:
                scr_puts(15, 15, "GAME OVER");
                game.state = st_exit;
                break;
            
            default: 
                break;
        }
    }

    for(;;);

    cleanup_platform();
    return 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////
static void display_logo(void)
{
    scr_clear();
    scr_print_score(game.score);
    scr_print_level(game.level + 1);
    scr_draw_border();

    scr_puts(8, 15, "Press any key when ready");
}

static void display_level_up(void)
{
    scr_print_level(game.level + 1);
    scr_puts(16, 14, "LEVEL UP");
    scr_puts( 8, 16, "Press any key when ready");
}

static void display_pause(void)
{
    scr_clear();
    scr_print_score(game.score);
    scr_print_level(game.level + 1);
    scr_draw_border();

    scr_puts(15, 14, "GAME PAUSED");
    scr_puts( 8, 16, "Press any key to continue");
}

static void display_level(uint32_t level)
{
    scr_clear();
    scr_print_score(game.score);
    scr_print_level(game.level + 1);
    scr_draw_border();
    switch (level % BASIC_LEVELS)
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
}

static void setup_snake(void)
{
    static const char snake[] = { scr_head_left, scr_body_horz, scr_body_horz, scr_body_horz, scr_body_horz, scr_tail_right };

    snake_init(snake, sizeof(snake));
    game.snake_head.col = SNAKE_STAR_COL;
    game.snake_head.row = SNAKE_STAR_ROW;
    game.snake_dir = dir_left;
}

static void setup_prize(void)
{
    uint32_t col;
    uint32_t row;
    do {
        col = 1 + rand() % (SCR_COLS - 2);
        row = 2 + rand() % (SCR_ROWS - 3);
    } while (!scr_is_empty(col, row));
    game.prize.col = col;
    game.prize.row = row;
}

static void display_prize(void)
{
    scr_putch(game.prize.col, game.prize.row, scr_prize);
}

static void process_game(void)
{
    game.snake_head = snake_move(game.snake_head, game.snake_dir);
    if ((game.snake_head.col == game.prize.col) && (game.snake_head.row == game.prize.row))
    {
        game.prizes_collected++;
        game.score += get_prize_cost();
        scr_print_score(game.score);
        snake_display(game.snake_head);
        if (game.prizes_collected == PRIZES_FOR_LEVEL_UP)
        {
            game.level++;
            display_level_up();
            game.state = st_wait_for_start;
            return;
        }
        snake_grow(get_growth_rate());
        setup_prize();
        display_prize();
        return;
    }
    if (scr_is_empty(game.snake_head.col, game.snake_head.row))
    {
        snake_display(game.snake_head);
        return;
    }
    game.state = st_game_over;
}

static uint32_t get_prize_cost(void)
{
    return 5 * (1 + game.level % BASIC_LEVELS);
}

static uint32_t get_growth_rate(void)
{
    return 1 + game.level % BASIC_LEVELS;
}
