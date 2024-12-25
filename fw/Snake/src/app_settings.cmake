set(DDR lmb_bram_0)
set(lmb_bram_0 "0x50;0xffb0")
set(lmb_bram_1 "0x100050;-0xff050")
set(TOTAL_MEM_CONTROLLERS "lmb_bram_0;lmb_bram_1")
set(MEMORY_SECTION "MEMORY
{
	lmb_bram_0 : ORIGIN = 0x50, LENGTH = 0xffb0
	lmb_bram_1 : ORIGIN = 0x100000, LENGTH = 0x1000
}")
set(STACK_SIZE 0x400)
set(HEAP_SIZE 0x800)
