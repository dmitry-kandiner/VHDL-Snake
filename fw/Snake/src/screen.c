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
    for (uint32_t i = 0; str[i] != '\0'; i++) vmem[row][col + i] = str[i];
}

#define MAX_DIGITS  (sizeof(buffer) - 1)
void scr_putnum(uint32_t col, uint32_t row, uint32_t num, char padding, uint32_t width)
{
    static char buffer[11] = {'\0'};

    uint32_t last_free_place = MAX_DIGITS;
    do {
        buffer[--last_free_place] = '0' + num % 10;
        num /= 10;
    } while (num > 0);
    while (MAX_DIGITS - last_free_place < width)
    {
        buffer[--last_free_place] = padding;
    }
    scr_puts(col, row, &buffer[last_free_place]);
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

void scr_print_score(uint32_t score)
{
    scr_puts(0, 0, "Score: ");
    scr_putnum(7, 0, score, '0', 6);
}

void scr_print_level(uint32_t level)
{
    scr_putnum(SCR_COLS - 2, 0, level, '0', 2);
    scr_puts(SCR_COLS - 9, 0, "Level: ");
}