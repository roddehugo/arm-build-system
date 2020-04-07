/* Linker script for the STM32F103x8 line.
 * ROM starts at address 0x08000000 with 64Kb of FLASH.
 * RAM starts at address 0x20000000 with 20Kb of SRAM.
 */

MEMORY
{
	rom (rx)  : ORIGIN = 0x08000000, LENGTH = 64K
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

INCLUDE cortex-m.ld
