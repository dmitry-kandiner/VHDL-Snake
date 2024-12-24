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
#include <string.h>
#include "xparameters.h"
#include "platform.h"


int main()
{
    static uint8_t* const vbuf = (void*)XPAR_LMB_BRAM_1_BASEADDRESS;
    static const char hello[] = "Hello, world!";

    init_platform();

    for (size_t i = 0; i < sizeof(hello); i++)
    {
        vbuf[i] = hello[i];
    }

    for (int i = 0; i < 40; i++)
    {
        vbuf[i] = 0x03;
    }

    memcpy(vbuf, hello, sizeof(hello));

    cleanup_platform();
    return 0;
}
