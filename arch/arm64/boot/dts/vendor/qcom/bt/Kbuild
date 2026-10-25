ifeq ($(CONFIG_ARCH_KALAMA),y)
dtbo-y += kalama-bt.dtbo
endif

ifeq ($(CONFIG_MMI_DEVICE_DTBS),y)

dtbo-$(CONFIG_ARCF_DTB) += pineapple-kiwi-bt-arcf-evt1a.dtbo
dtbo-$(CONFIG_CTWOV_DTB) += pineapple-kiwi-bt-ctwov-evb.dtbo

dtbo-$(CONFIG_ARCFOX_DTB) += cliffs-kiwi-bt-arcfox-evt3.dtbo
dtbo-$(CONFIG_CTWO_DTB) += cliffs-kiwi-bt-ctwo-evb3.dtbo

else

ifeq ($(CONFIG_ARCH_PINEAPPLE),y)
dtbo-y += pineapple-kiwi-bt.dtbo
dtbo-y += pineapple-hdk-kiwi-bt.dtbo
endif

endif  # end of CONFIG_MMI_DEVICE_DTBS

ifeq ($(CONFIG_ARCH_WAIPIO),y)
dtbo-y += waipio-bt.dtbo
dtbo-y += waipio-kiwi-bt.dtbo
endif

ifeq ($(CONFIG_ARCH_BLAIR),y)
dtbo-y += blair-bt.dtbo
endif

ifeq ($(CONFIG_ARCH_TRINKET), y)
dtbo-y += trinket-bt-v1.dtbo
endif

ifeq ($(CONFIG_ARCH_HOLI),y)
dtbo-y += holi-mtp-pm6125-nopmi-overlay-bt.dtbo
dtbo-y += holi-qrd-pm6125-nopmi-overlay-bt.dtbo
dtbo-y += holi-bt.dtbo
dtbo-y += holi-pm6125-bt.dtbo
endif

ifeq ($(CONFIG_ARCH_CLIFFS), y)
dtbo-y += cliffs-kiwi-bt.dtbo
dtbo-y += cliffs-qca6750-bt.dtbo
endif

always-y        := $(dtb-y) $(dtbo-y)
subdir-y        := $(dts-dirs)
clean-files     := *.dtb *.dtbo
