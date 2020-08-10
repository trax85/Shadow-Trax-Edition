/* Copyright (c) 2002,2007-2015, The Linux Foundation. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 and
 * only version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#define ANY_ID (~0)

static const struct adreno_gpu_core adreno_gpulist[] = {
	{
		.gpurev = ADRENO_REV_A530,
		.core = 5,
		.major = 3,
		.minor = 0,
		.patchid = 0,
		.pm4fw_name = "a530v1_pm4.fw",
		.pfpfw_name = "a530v1_pfp.fw",
		.gpudev = &adreno_a5xx_gpudev,
		.gmem_size = SZ_1M,
		.num_protected_regs = 0x20,
		.busy_mask = 0xFFFFFFFE,
	},
	{
		.gpurev = ADRENO_REV_A530,
		.core = 5,
		.major = 3,
		.minor = 0,
		.patchid = ANY_ID,
		.features = ADRENO_GPMU | ADRENO_SPTP_PC | ADRENO_LM,
		.pm4fw_name = "a530_pm4.fw",
		.pfpfw_name = "a530_pfp.fw",
		.zap_name = "a530_zap",
		.gpudev = &adreno_a5xx_gpudev,
		.gmem_size = SZ_1M,
		.num_protected_regs = 0x20,
		.gpmufw_name = "a530_gpmu.fw2",
		.gpmu_major = 1,
		.gpmu_minor = 0,
		.lm_major = 3,
		.lm_minor = 0,
		.gpmu_tsens = 0x00060007,
		.max_power = 5448,
		.regfw_name = "a530v2_seq.fw2",
		.busy_mask = 0xFFFFFFFE,
	},
	{
		.gpurev = ADRENO_REV_A510,
		.core = 5,
		.major = 1,
		.minor = 0,
		.patchid = ANY_ID,
		.features = ADRENO_64BIT | ADRENO_CONTENT_PROTECTION,
		.pm4fw_name = "a530_pm4.fw",
		.pfpfw_name = "a530_pfp.fw",
		.gpudev = &adreno_a5xx_gpudev,
		.gmem_size = SZ_256K,
		.num_protected_regs = 0x20,
		.busy_mask = 0xFFFFFFFE,
	},
};
