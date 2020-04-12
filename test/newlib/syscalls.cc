#include <reent.h>
#include <time.h>
#include <errno.h>

/* Increase program data space. As malloc and related functions depend on this,
 * it is useful to have a working implementation. The following suffices for a
 * standalone system; it exploits the symbol end defined in linker script. */
extern "C" void *
_sbrk_r (struct _reent *ptr, int incr)
{
    extern char end; // Defined in linker script.
    static char *heap_end;
    char *prev_heap_end;
    if (heap_end == 0)
        heap_end = &end;
    prev_heap_end = heap_end;
    heap_end += incr;
    return (void *) prev_heap_end;
}

/* Exit a program without cleaning up files. If your system does not provide
 * this, it is best to avoid linking with subroutines that require it. */
extern "C" void
_exit (int n)
{
    asm volatile ("bkpt");
    while (1)
        ;
}

/* Process-ID; sometimes used to generate strings unlikely to conflict with
 * other processes. Minimal implementation for a system without processes. */
extern "C" int
_getpid_r (struct _reent *ptr)
{
    return 1;
}

/* Query whether output stream is a terminal. For consistency with the other
 * minimal implementations, which only support output to stdout. */
extern "C" int
_isatty_r (struct _reent *ptr, int fd)
{
    return 1;
}

/* Send a signal, no process, no signal. */
extern "C" int
_kill_r (struct _reent *ptr, int pid, int sig)
{
    ptr->_errno = EINVAL;
    return -1;
}

/* Set position in a file. Minimal implementation. */
extern "C" off_t
_lseek_r (struct _reent *ptr, int fd, off_t pos, int whence)
{
    ptr->_errno = ENOSYS;
    return -1;
}

/* Open a file. Minimal implementation. */
extern "C" int
_open_r (struct _reent *ptr, const char *file, int flags, int mode)
{
    ptr->_errno = ENOSYS;
    return -1;
}

/* Close a file. Minimal implementation. */
extern "C" int
_close_r (struct _reent *ptr, int fd)
{
    ptr->_errno = EBADF;
    return -1;
}

/* Status of open file. Minimal implementation. */
extern "C" int
_fstat_r (struct _reent *ptr, int fd, struct stat *st)
{
    ptr->_errno = EBADF;
    return -1;
}

/* Read from a file. Minimal implementation. */
extern "C" int
_read_r (struct _reent *ptr, int fd, void *buf, size_t cnt)
{
    ptr->_errno = EBADF;
    return -1;
}

/* Write to a file. Minimal implementation. */
extern "C" int
_write_r (struct _reent *ptr, int fd, const void *buf, size_t cnt)
{
    ptr->_errno = EBADF;
    return -1;
}

/* Remove a file's directory entry. Minimal implementation. */
extern "C" int
_unlink_r (struct _reent *ptr, const char *pathname)
{
    ptr->_errno = ENOENT;
    return -1;
}

/* Establish a new name for an existing file. Minimal implementation. */
extern "C" int
_link_r (struct _reent *ptr, const char *oldname, const char *newname)
{
    ptr->_errno = EMLINK;
    return -1;
}

/* Timing information for current process. Minimal implementation. */
extern "C" clock_t
_times_r (struct _reent *ptr, struct tms *ptms)
{
    ptr->_errno = ENOSYS;
    return -1;
}

/* Get time of day. Minimal implementation. */
extern "C" int
_gettimeofday_r (struct _reent *ptr, struct timeval *ptimeval, void *ptimezone)
{
    ptr->_errno = ENOSYS;
    return -1;
}

