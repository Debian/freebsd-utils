/* Disable structs provided by <sys/kglue/net/if.h>. */
#define ifaliasreq	gnu_ifaliasreq
#define ifmediareq	gnu_ifmediareq
#define ifdrv		gnu_ifdrv
#include_next <net/if.h>
#undef ifaliasreq
#undef ifmediareq
#undef ifdrv

/* Include kernel header with FreeBSD version of the structs. */
#include <sys/kglue/net/if.h>
