# SPDX-License-Identifier: BSD-3-Clause
# Copyright(c) 2018 Luca Boccassi <bluca@debian.org>

if not dpdk_conf.get('RTE_ARCH_64')
	error('Only 64-bit compiles are supported for this platform type')
endif
dpdk_conf.set('RTE_ARCH', 'sw_64')
dpdk_conf.set('RTE_ARCH_SW_64', 1)
dpdk_conf.set('RTE_MAX_LCORE', 1536)
dpdk_conf.set('RTE_MAX_NUMA_NODES', 32)
dpdk_conf.set('RTE_CACHE_LINE_SIZE', 128)
dpdk_conf.set('RTE_FORCE_INTRINSICS', 'y')

