#ifndef _RTE_CPUFLAGS_sw_64_H_
#define _RTE_CPUFLAGS_sw_64_H_

#ifdef __cplusplus
extern "C" {
#endif

/* Enumeration of all CPU features supported */

enum rte_cpu_flag_t {
	RTE_CPUFLAG_NUMFLAGS /**< This should always be the last! */
	};

#include "generic/rte_cpuflags.h"

#ifdef __cplusplus
}
#endif

#endif /* _RTE_CPUFLAGS_sw_64_H_ */


