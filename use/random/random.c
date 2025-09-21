#include <stdlib.h>
#include <time.h>

/* Note, this one might not be the fastest one
 * But safe? hell yea */
int randint(int lower, int upper) {
    // Swap bounds if lower is bigger that upper
    if (lower > upper) {
        int t = lower;
        lower = upper;
        upper = t;
    }

    static int seeded = 0;

    if (!seeded) {
        srand( (unsigned) time(NULL) );
        seeded = 1;
    }

    long range = (long)upper - (long)lower + 1;
    if (range <= 0) return lower;

    int r = rand();
    int limit = RAND_MAX - (RAND_MAX % (int) range);

    // Distribute the random numbers
    if (r >= limit)
        return randint(lower, upper);
    return lower + (r % (int) range);
}
