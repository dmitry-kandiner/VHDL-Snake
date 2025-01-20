#ifndef SNAKE_H
#define SNAKE_H

#include <stdint.h>

#include "main.h"

#define MAX_SNAKE_LENGTH    (256)

void snake_init(const char* const body, uint32_t length);
void snake_display(position_t head);
position_t snake_move(position_t head, direction_t direction);
void snake_grow(uint32_t growth_rate);

#endif // SNAKE_H