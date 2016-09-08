/*
 * arch/arm64/include/asm/arch_timer.h
 *
 * Copyright (C) 2012 ARM Ltd.
 * Author: Marc Zyngier <marc.zyngier@arm.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef __ASM_ARCH_TIMER_H
#define __ASM_ARCH_TIMER_H

#include <asm/barrier.h>
#include <asm/sysreg.h>

#include <linux/init.h>
#include <linux/types.h>

#include <clocksource/arm_arch_timer.h>

static inline void arch_timer_reg_write_cp15(int access, int reg, u32 val)
{
	if (access == ARCH_TIMER_PHYS_ACCESS) {
		switch (reg) {
		case ARCH_TIMER_REG_CTRL:
			write_sysreg(val, cntp_ctl_el0);
			break;
		case ARCH_TIMER_REG_TVAL:
			write_sysreg(val, cntp_tval_el0);
			break;
		default:
			BUILD_BUG();
		}
	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
		switch (reg) {
		case ARCH_TIMER_REG_CTRL:
			write_sysreg(val, cntv_ctl_el0);
			break;
		case ARCH_TIMER_REG_TVAL:
			write_sysreg(val, cntv_tval_el0);
			break;
		default:
			BUILD_BUG();
		}
	} else {
		BUILD_BUG();
	}

	isb();
}

static inline u32 arch_timer_reg_read_cp15(int access, int reg)
{
	if (access == ARCH_TIMER_PHYS_ACCESS) {
		switch (reg) {
		case ARCH_TIMER_REG_CTRL:
			return read_sysreg(cntp_ctl_el0);
		case ARCH_TIMER_REG_TVAL:
			return read_sysreg(cntp_tval_el0);
		default:
			BUILD_BUG();
		}
	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
		switch (reg) {
		case ARCH_TIMER_REG_CTRL:
			return read_sysreg(cntv_ctl_el0);
		case ARCH_TIMER_REG_TVAL:
			return read_sysreg(cntv_tval_el0);
		default:
			BUILD_BUG();
		}
	} else {
		BUILD_BUG();
	}

	BUG();
}

static inline u32 arch_timer_get_cntfrq(void)
{
	return read_sysreg(cntfrq_el0);
}

static inline u32 arch_timer_get_cntkctl(void)
{
	return read_sysreg(cntkctl_el1);
}

static inline void arch_timer_set_cntkctl(u32 cntkctl)
{
	write_sysreg(cntkctl, cntkctl_el1);
}

static inline void arch_timer_evtstrm_enable(int divider)
{
	u32 cntkctl = arch_timer_get_cntkctl();
	cntkctl &= ~ARCH_TIMER_EVT_TRIGGER_MASK;
	/* Set the divider and enable virtual event stream */
	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
			| ARCH_TIMER_VIRT_EVT_EN;
	arch_timer_set_cntkctl(cntkctl);
	elf_hwcap |= HWCAP_EVTSTRM;
#ifdef CONFIG_COMPAT
	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
#endif
}

static inline u64 arch_counter_get_cntvct_cp15(void)
{
	u64 cval;

	isb();
	cval = read_sysreg(cntvct_el0);

	return cval;
}

static inline u64 arch_counter_get_cntpct_cp15(void)
{
	u64 cval;

	isb();
	asm volatile("mrs %0, cntpct_el0" : "=r" (cval));

	return cval;
}

static inline int arch_timer_arch_init(void)
{
	return 0;
}

#endif
