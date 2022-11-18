#ifndef _RTE_ATOMIC_sw_64_H_
#define _RTE_ATOMIC_sw_64_H_

#ifndef RTE_FORCE_INTRINSICS
//# error Platform must be built with CONFIG_RTE_FORCE_INTRINSICS
#endif

#ifdef __cplusplus
extern "C" {
#endif

#include "generic/rte_atomic.h"

#define swmb() asm volatile("memb": : :"memory")

#define rte_mb() swmb()

#define rte_wmb() swmb()

#define rte_rmb() swmb()

#define rte_smp_mb() swmb()

#define rte_smp_wmb() swmb()

#define rte_smp_rmb() swmb()

#define rte_io_mb() rte_mb()

#define rte_io_wmb() rte_wmb()

#define rte_io_rmb() rte_rmb()

#define rte_cio_rmb() rte_rmb()

#define rte_cio_wmb() rte_wmb()

static __rte_always_inline void
rte_atomic_thread_fence(int memorder)
{
	__atomic_thread_fence(memorder);
}

#ifdef __cplusplus
}
#endif

#endif /* _RTE_ATOMIC_sw_64_H_ */

