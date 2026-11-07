# SPDX-License-Identifier: GPL-2.0-only
KERNEL_SRC := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)
VENDOR := vendor/qcom/opensource
KBUILD_ARGS = O=$(KERNEL_OUT) ARCH=arm64 LLVM=$(LLVM) LLVM_IAS=1 \
	KCFLAGS=-D__ANDROID_COMMON_KERNEL__ LOCALVERSION= KERNEL_SRC=$(KERNEL_SRC)

.PHONY: help check-inputs securemsm
.DEFAULT_GOAL := help

help:
	@printf '%s\n' 'Targets: securemsm' \
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
