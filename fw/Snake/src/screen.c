#include <stdio.h>
#include <stdint.h>
#include <memory.h>
#include "screen.h"

static char vmem[SCR_ROWS][SCR_COLS] __attribute__ ((section (".vmem")));

#define FIELD_FIRST_ROW     (1)
#define FIELD_LAST_ROW      (SCR_ROWS - 1)
#define FIELD_FIRST_COL     (0)
#define FIELD_LAST_COL      (SCR_COLS - 1)

void scr_clear(void)
{
    memset(vmem, 0x00, sizeof(vmem));
}

void scr_putch(uint32_t col, uint32_t row, char ch)
{
    vmem[row][col] = ch;
}

void scr_puts(uint32_t col, uint32_t row, const char* const str)
{
    strcpy(&vmem[row][col], str);
}

void scr_draw_border(void)
{
    memset(&vmem[FIELD_FIRST_ROW][0], scr_wall, SCR_COLS);
    memset(&vmem[FIELD_LAST_ROW ][0], scr_wall, SCR_COLS);

    for (int i = FIELD_FIRST_ROW + 1; i < FIELD_LAST_ROW; i++)
    {
        scr_putch(FIELD_FIRST_COL, i, scr_wall);
        scr_putch(FIELD_LAST_COL,  i, scr_wall);
    }
}

void scr_draw_score(uint32_t score)
{
    char buffer[32];
    sprintf(buffer, "Score: %06lu", score);
    scr_puts(0, 0, buffer);
}