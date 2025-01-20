#include <stdint.h>
#include <memory.h>

#include "snake.h"
#include "screen.h"

static const char neck[directions_count][directions_count] = {
//  dir:  up             right          down           left      |  curr_dir:
    { scr_body_vert, scr_corner_ul, scr_body_vert, scr_corner_ur }, // up
    { scr_corner_br, scr_body_horz, scr_corner_ur, scr_body_horz }, // right
    { scr_body_vert, scr_corner_bl, scr_body_vert, scr_corner_br }, // down
    { scr_corner_bl, scr_body_horz, scr_corner_ul, scr_body_horz }  // left
};

static struct {
    uint32_t length;
    char     body[MAX_SNAKE_LENGTH];
    uint32_t growth;
    uint32_t tail_col;
    uint32_t tail_row;
} snake;

void snake_init(const char* const body, uint32_t length)
{
    if (length > MAX_SNAKE_LENGTH) length = MAX_SNAKE_LENGTH;
    memcpy(snake.body, body, length);
    snake.length = length;
    snake.tail_col = 0;
    snake.tail_row = 0;
}

void snake_display(position_t head)
{
    uint32_t col = head.col;
    uint32_t row = head.row;
    uint32_t tail_col;
    uint32_t tail_row;
    direction_t dir;

    for (uint32_t i = 0; i < snake.length; i++)
    {
        scr_putch(col, row, snake.body[i]);
        switch (snake.body[i])
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
        tail_col = col;
        tail_row = row;
        switch (dir)
        {
            case dir_up:    row--; break;
            case dir_right: col++; break;
            case dir_down:  row++; break;
            case dir_left:  col--; break;
            default: break;
        }
    }
    if ((snake.tail_col != 0) || (snake.tail_row != 0))
    {
        scr_putch(snake.tail_col, snake.tail_row, scr_empty);
    }
    snake.tail_col = tail_col;
    snake.tail_row = tail_row;
}

position_t snake_move(position_t head, direction_t dir)
{
    if (snake.growth == 0)
    {
        char tail = snake.body[snake.length - 1];
        switch (snake.body[snake.length - 2])
        {
            case scr_corner_ul: tail = (tail == scr_tail_right) ? scr_tail_up   : scr_tail_left; break;
            case scr_corner_ur: tail = (tail == scr_tail_left ) ? scr_tail_up   : scr_tail_right;  break;
            case scr_corner_bl: tail = (tail == scr_tail_right) ? scr_tail_down : scr_tail_left; break;
            case scr_corner_br: tail = (tail == scr_tail_left ) ? scr_tail_down : scr_tail_right;  break;
        }
        snake.body[snake.length - 1] = tail;
        memmove(&snake.body[2], &snake.body[1], snake.length - 3);
    }
    else
    {
        if (snake.length < MAX_SNAKE_LENGTH)
        {
            memmove(&snake.body[2], &snake.body[1], snake.length - 1);
            snake.length++;
            snake.tail_col = 0;
            snake.tail_row = 0;
        }            
        snake.growth--;
    }

    direction_t curr_dir;
    switch (snake.body[0])
    {
        case scr_head_up:    curr_dir = dir_up;    if (dir == dir_down)  dir = curr_dir; break;
        case scr_head_right: curr_dir = dir_right; if (dir == dir_left)  dir = curr_dir; break;
        case scr_head_down:  curr_dir = dir_down;  if (dir == dir_up)    dir = curr_dir; break;
        case scr_head_left:  curr_dir = dir_left;  if (dir == dir_right) dir = curr_dir; break;
    }
    snake.body[1] = neck[curr_dir][dir];

    switch (dir)
    {
        case dir_up:    head.row--; snake.body[0] = scr_head_up;    break;
        case dir_right: head.col++; snake.body[0] = scr_head_right; break;
        case dir_down:  head.row++; snake.body[0] = scr_head_down;  break;
        case dir_left:  head.col--; snake.body[0] = scr_head_left;  break;
        default: break;
    }
    return head;
}

void snake_grow(uint32_t growth_rate)
{
    snake.growth += growth_rate;
}
