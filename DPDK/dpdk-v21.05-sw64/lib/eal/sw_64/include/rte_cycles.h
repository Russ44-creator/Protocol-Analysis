#ifndef _RTE_CYCLES_sw_64_H_
#define _RTE_CYCLES_sw_64_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "generic/rte_cycles.h"

static inline uint64_t
rte_rdtsc(void)
{
	uint64_t u64_TSC;
	asm volatile("RTC %0":"=r"(u64_TSC));
	return u64_TSC;
}

static inline uint64_t
rte_rdtsc_precise(void)
{
	rte_mb();
	return rte_rdtsc();
}

static inline uint64_t
rte_get_tsc_cycles(void)
{
	return rte_rdtsc();
}

#ifdef __cplusplus
}
#endif

#endif /* _RTE_CYCLES_sw_64_H_ */

