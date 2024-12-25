/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <sleep.h>
#include <stdbool.h>
#include "xparameters.h"
#include "platform.h"


int main()
{
    static uint8_t* const vbuf = (void*)XPAR_LMB_BRAM_1_BASEADDRESS;
    static volatile uint32_t* const kbd_in = (void*)0x200020;
    //static const char hex[] = "0123456789ABCDEF";

    init_platform();

    uint32_t prev_codes = 0x00000000;
    for(;;)
    {
        uint32_t scancodes = *kbd_in;

        if (prev_codes == scancodes) continue;
        prev_codes = scancodes;

        bool is_released = (scancodes & 0x0000FF00) == 0x0000F000;
        char* key;

        switch (scancodes & 0x000000FF)
        {
            case 0x75: key = "up arrow   "; break;
            case 0x74: key = "right arrow"; break;
            case 0x72: key = "down arrow "; break;
            case 0x6B: key = "left arrow "; break;
            case 0x29: key = "space bar  "; break;
            case 0x76: key = "escape     "; break;
            default:   key = "unknown key"; break;
        }

        strcpy(vbuf + 81, key);
        strcpy(vbuf + 121, is_released ? "released" : "pressed ");

        // for(size_t i = 0; i < sizeof(uint32_t) * 2; i++)
        // {
        //     char ch = hex[(scancodes & 0xF0000000) >> 28];
        //     scancodes <<= 4;
        //     vbuf[81+i] = ch;
        // }
        //usleep(10000);
    }

    cleanup_platform();
    return 0;
}
