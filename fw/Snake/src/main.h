#ifndef MAIN_H
#define MAIN_H

#include <stdint.h>

typedef enum {
    dir_up,
    dir_right,
    dir_down,
    dir_left,
    directions_count
} direction_t;

typedef struct {
    uint32_t col;
    uint32_t row;
} position_t;

#endif // MAIN_H