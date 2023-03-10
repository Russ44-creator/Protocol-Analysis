/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(c) 2021 Intel Corporation
 */

#include "rte_power_intrinsics.h"

/**
 * This function is not supported on SW.
 */
int
rte_power_monitor(const struct rte_power_monitor_cond *pmc,
		const uint64_t tsc_timestamp)
{
	RTE_SET_USED(pmc);
	RTE_SET_USED(tsc_timestamp);

	return -ENOTSUP;
}

/**
 * This function is not supported on SW.
 */
int
rte_power_pause(const uint64_t tsc_timestamp)
{
	RTE_SET_USED(tsc_timestamp);

	return -ENOTSUP;
}

/**
 * This function is not supported on SW.
 */
int
rte_power_monitor_wakeup(const unsigned int lcore_id)
{
	RTE_SET_USED(lcore_id);

	return -ENOTSUP;
}
