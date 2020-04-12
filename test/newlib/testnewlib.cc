#include <algorithm>
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>

static char hello[] = "Hello World!";

template<class T, int N>
constexpr int
lengthof (T (&)[N])
{
    return N;
}

int
main ()
{
    int a, b;
    char buffer[32];

    std::strncpy (buffer, hello, std::min (lengthof (hello), lengthof (buffer)));

    printf ("%s\n", buffer);
    printf ("Enter two numbers: ");
    scanf ("%d %d", &a, &b);
    printf ("\n");
    printf ("%d + %d = %d\n", a, b, a + b);

    FILE *fp = std::fopen ("any", "r");
    assert (fp);
    std::fclose (fp);

    return 0;
}
