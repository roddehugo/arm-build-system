/* Define entry point of the output file. */
ENTRY(entry)

/* Define sections. */
SECTIONS
{
	/* TEXT section for code & constants.
	 * Keep the vector table at the very beginning!
	 */
	.text : {
		KEEP(*(.vectors))
		*(.text*)
		. = ALIGN(4);
		*(.rodata*)
		. = ALIGN(4);
	} >rom

	/* C++ Static constructors/destructors, also used for
	 * __attribute__ ((constructor)) and the likes.
	 */
	.preinit_array : {
		. = ALIGN(4);
		__preinit_array_start = .;
		KEEP (*(.preinit_array))
		__preinit_array_end = .;
	} >rom
	.init_array : {
		. = ALIGN(4);
		__init_array_start = .;
		KEEP (*(SORT(.init_array.*)))
		KEEP (*(.init_array))
		__init_array_end = .;
	} >rom
	.fini_array : {
		. = ALIGN(4);
		__fini_array_start = .;
		KEEP (*(.fini_array))
		KEEP (*(SORT(.fini_array.*)))
		__fini_array_end = .;
	} >rom

	/* Another section used by C++ stuff, appears when using newlib with
	 * 64bit (long long) printf support.
	 */
	.ARM.extab : {
		*(.ARM.extab*)
	} >rom
	.ARM.exidx : {
		__exidx_start = .;
		*(.ARM.exidx*)
		__exidx_end = .;
	} >rom

	. = ALIGN(4);
	_etext = .;

	/* DATA section with is used for initialized data.
	 * Should be loaded to ROM and copied to RAM.
	 */
	.data : {
		_data = .;
		*(.data*)
		. = ALIGN(4);
		_edata = .;
	} >ram AT >rom
	_data_loadaddr = LOADADDR(.data);

	/* BSS section which is used for uninitialized static data.
	 * Nothing to load, all variables will be initialized to zero.
	 */
	.bss (NOLOAD) : {
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);
		_ebss = .;
	} >ram

	/* The .eh_frame section is used for C++ exception handling. */
	/DISCARD/ : { *(.eh_frame) }

	. = ALIGN(4);
	end = .;
}

/* Point to the very end of the RAM. */
PROVIDE(_stack = ORIGIN(ram) + LENGTH(ram));
