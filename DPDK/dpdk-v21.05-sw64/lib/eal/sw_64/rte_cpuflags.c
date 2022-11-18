#include "rte_cpuflags.h"
#include <errno.h>

/**
 * Checks if a particular flag is available on current machine.
 */

int
rte_cpu_get_flag_enabled(__attribute__((unused)) enum rte_cpu_flag_t feature)
{
	return -ENOENT;
}

void
rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
{
	memset(intrinsics, 0, sizeof(*intrinsics));
}

