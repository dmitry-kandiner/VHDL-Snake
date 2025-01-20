#include <stdint.h>

#include "timer.h"

static volatile uint32_t* const tmr_preload = (void*)0x200040;
static volatile uint32_t* const tmr_counter = (void*)0x200044;
static volatile uint32_t* const tmr_control = (void*)0x200048;

#define TIM_ENA     0x00000001
#define TIM_AUTO    0x00000002

void tim_init(void)
{
    *tmr_preload = 0xFFFFFFFF;
    *tmr_control = TIM_ENA | TIM_AUTO;
}

uint32_t tim_get(void)
{
    return *tmr_counter;
}
