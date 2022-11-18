#ifndef _RTE_PAUSE_sw_64_H_
#define _RTE_PAUSE_sw_64_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <rte_common.h>
#include "generic/rte_pause.h"

static inline void rte_pause(void)
{
	asm volatile("memb" ::: "memory");
}

#ifdef __cplusplus
}
#endif

#endif /* _RTE_PAUSE_sw_64_H_ */

