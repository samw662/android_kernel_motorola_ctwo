# SPDX-License-Identifier: GPL-2.0-only
KERNEL_SRC := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)
VENDOR := vendor/qcom/opensource
MM_ROOT := $(KERNEL_SRC)/$(VENDOR)/mm-drivers/
KBUILD_ARGS = O=$(KERNEL_OUT) ARCH=arm64 LLVM=$(LLVM) LLVM_IAS=1 \
	KCFLAGS=-D__ANDROID_COMMON_KERNEL__ LOCALVERSION= KERNEL_SRC=$(KERNEL_SRC)

.PHONY: help check-inputs securemsm mmrm hw-fence sync-fence ext-display synx dsp graphics rmnet-mem rmnet-sch
.DEFAULT_GOAL := help

help:
	@printf '%s\n' 'Targets: securemsm mmrm hw-fence sync-fence ext-display synx dsp graphics rmnet-mem rmnet-sch' \
	  'Set KERNEL_OUT to a prepared kernel output and LLVM to the toolchain prefix.'

check-inputs:
	@test -n "$(KERNEL_OUT)" && test -f "$(KERNEL_OUT)/.config" && \
	  test -s "$(KERNEL_OUT)/Module.symvers" || \
	  { printf '%s\n' 'KERNEL_OUT must contain .config and Module.symvers' >&2; exit 1; }
	@test -n "$(LLVM)" || { printf '%s\n' 'Set LLVM to the toolchain prefix' >&2; exit 1; }

securemsm: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/securemsm-kernel \
	  SSG_MODULE_ROOT=$(KERNEL_SRC)/$(VENDOR)/securemsm-kernel \
	  CONFIG_QSEECOM=n BOARD_PLATFORM=pineapple modules

mmrm: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/mmrm-driver \
	  MMRM_ROOT=$(KERNEL_SRC)/$(VENDOR)/mmrm-driver BOARD_PLATFORM=pineapple modules

hw-fence: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/mm-drivers/hw_fence \
	  MSM_HW_FENCE_ROOT=$(MM_ROOT) BOARD_PLATFORM=pineapple modules

sync-fence: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/mm-drivers/sync_fence \
	  SYNC_FENCE_ROOT=$(MM_ROOT) BOARD_PLATFORM=pineapple modules

ext-display: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/mm-drivers/msm_ext_display \
	  MSM_EXT_DISPLAY_ROOT=$(MM_ROOT) BOARD_PLATFORM=pineapple modules

synx: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/synx-kernel \
	  SYNX_ROOT=$(KERNEL_SRC)/$(VENDOR)/synx-kernel BOARD_PLATFORM=pineapple modules

dsp: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/dsp-kernel \
	  DSP_ROOT=$(KERNEL_SRC)/$(VENDOR)/dsp-kernel BOARD_PLATFORM=pineapple modules

graphics: hw-fence
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/graphics-kernel \
	  KGSL_PATH=$(KERNEL_SRC)/$(VENDOR)/graphics-kernel CONFIG_QCOM_KGSL=m \
	  BOARD_PLATFORM=pineapple \
	  KBUILD_EXTRA_SYMBOLS=$(KERNEL_OUT)/$(VENDOR)/mm-drivers/hw_fence/Module.symvers modules

rmnet-mem: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/datarmnet-ext/mem modules

rmnet-sch: check-inputs
	+$(MAKE) -C $(KERNEL_SRC) $(KBUILD_ARGS) M=$(VENDOR)/datarmnet-ext/sch modules
