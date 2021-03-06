/* This symbol is used by dynamic shared objects to identify them, but it is
 * somehow pulled in as a dependency by the compiler-generated global (static)
 * constructor code.  This simple definition will do.  See:
 * http://lists.debian.org/debian-gcc/2003/07/msg00057.html
 */
void *__dso_handle = (void*) &__dso_handle;

/* This function is called when a pure virtual function is called. Calling this
 * function is an error.  Replace the one provided by the toolchain to avoid
 * including the world.
 */
extern "C" void
__cxa_pure_virtual (void)
{
    asm volatile ("bkpt");
    while (1)
        ;
}

/* This function is called by exit or when a shared library is unloaded. Not
 * really used on an embedded system where you pull the power to shut down the
 * program.  This is called by code automatically generated by the C++ compiler.
 */
extern "C" int
__cxa_atexit (void (*) (void *), void *, void *)
{
    // Pretend everything is going alright.
    return 0;
}

namespace __gnu_cxx {

/* Override the verbose termination handler.  The default implementation of
 * __gnu_cxx::__verbose_terminate_handler comes with gcc and will print the name
 * of unhandled exceptions to stderr before terminating the program.  However,
 * in order to get the name of the exceptions a large chunk of name demangling
 * code is pulled in as well (several tens of kBytes!).  See:
 * http://www.webalice.it/fede.tft/cpp_on_microcontrollers_tricks/cpp_on_microcontrollers_tricks.html
 */
void
__verbose_terminate_handler ()
{
    asm volatile ("bkpt");
    while (1)
        ;
}

} //namespace __gnu_cxx
