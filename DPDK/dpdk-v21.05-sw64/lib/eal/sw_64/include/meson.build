# SPDX-License-Identifier: BSD-3-Clause
# Copyright(c) 2018 Luca Boccassi <bluca@debian.org>

arch_headers = files(
		'rte_byteorder.h',
		'rte_cycles.h',
		'rte_mcslock.h',
		'rte_pause.h',
		'rte_rwlock.h',
		'rte_ticketlock.h',
		'rte_atomic.h',
		'rte_cpuflags.h',
		'rte_io.h',
		'rte_memcpy.h',
		'rte_prefetch.h',
		'rte_spinlock.h',
		'rte_vect.h',
		'rte_power_intrinsics.h',
		'rte_pflock.h',
)

install_headers(arch_headers, subdir: get_option('include_subdir_arch'))
