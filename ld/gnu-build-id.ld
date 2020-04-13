/* Define sections. */
SECTIONS
{
	/* Instructs the linker to append the contents of .note.gnu.build-id to
	 * the rom region of memory and create a symbol to point to it. */
	.gnu_build_id : {
		PROVIDE(_build_id = .);
		*(.note.gnu.build-id);
	} > rom
}
