/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(c) 2015 Cavium, Inc
 */

#ifndef _TEST_XMMT_OPS_H_
#define _TEST_XMMT_OPS_H_

#include <rte_vect.h>

#if defined(RTE_ARCH_ARM)

/* vect_* abstraction implementation using NEON */

/* loads the xmm_t value from address p(does not need to be 16-byte aligned)*/
#define vect_loadu_sil128(p) vld1q_s32((const int32_t *)p)

/* sets the 4 signed 32-bit integer values and returns the xmm_t variable */
static __rte_always_inline xmm_t
vect_set_epi32(int i3, int i2, int i1, int i0)
{
	int32_t data[4] = {i0, i1, i2, i3};

	return vld1q_s32(data);
}

#elif defined(RTE_ARCH_X86)

/* vect_* abstraction implementation using SSE */

/* loads the xmm_t value from address p(does not need to be 16-byte aligned)*/
#define vect_loadu_sil128(p) _mm_loadu_si128(p)

/* sets the 4 signed 32-bit integer values and returns the xmm_t variable */
#define vect_set_epi32(i3, i2, i1, i0) _mm_set_epi32(i3, i2, i1, i0)

#elif defined(RTE_ARCH_PPC_64)

/* vect_* abstraction implementation using ALTIVEC */

/* loads the xmm_t value from address p(does not need to be 16-byte aligned)*/
#define vect_loadu_sil128(p) vec_ld(0, p)

/* sets the 4 signed 32-bit integer values and returns the xmm_t variable */
static __rte_always_inline xmm_t
vect_set_epi32(int i3, int i2, int i1, int i0)
{
	xmm_t data = (xmm_t){i0, i1, i2, i3};

	return data;
}

#elif defined(RTE_ARCH_SW_64)

#define vect_loadu_sil128(p) (*(xmm_t *)p)

static __rte_always_inline xmm_t
vect_set_epi32(int i3, int i2, int i1, int i0)
{
        uint64_t h = ((uint64_t)i2 & 0xffffffff) | ((uint64_t)i3 << 32);
        uint64_t l = ((uint64_t)i0 & 0xffffffff) | ((uint64_t)i1 << 32);

        xmm_t data = {l,h};

        return data;
}

#endif

#endif /* _TEST_XMMT_OPS_H_ */
