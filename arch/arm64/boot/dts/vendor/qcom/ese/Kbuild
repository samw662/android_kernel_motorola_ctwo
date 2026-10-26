ifeq ($(CONFIG_MMI_DEVICE_DTBS),y)

dtbo-$(CONFIG_ARCF_DTB) += pineapple-ese-arcf-evt1a.dtbo
dtbo-$(CONFIG_CTWOV_DTB) += pineapple-ese-ctwov-evb.dtbo

dtbo-$(CONFIG_ARCFOX_DTB) += pineapple-ese-arcfox-evt3.dtbo
dtbo-$(CONFIG_CTWO_DTB) += pineapple-ese-ctwo-evb3.dtbo

else
ifeq ($(CONFIG_ARCH_PINEAPPLE),y)
dtbo-y += pineapple-ese-mtp.dtbo
dtbo-y += pineapple-ese-cdp.dtbo
dtbo-y += pineapple-ese-qrd.dtbo
dtbo-y += pineapple-v2-ese-mtp.dtbo
dtbo-y += pineapple-v2-ese-cdp.dtbo
dtbo-y += pineapple-v2-ese-qrd.dtbo
endif

ifeq ($(CONFIG_ARCH_CLIFFS),y)
dtbo-y += cliffs-ese-mtp.dtbo
dtbo-y += cliffs-ese-cdp.dtbo
dtbo-y += cliffs-ese-qrd.dtbo
endif

ifeq ($(CONFIG_ARCH_SUN),y)
dtbo-y += sun-ese-mtp.dtbo
dtbo-y += sun-ese-cdp.dtbo
dtbo-y += sun-ese-qrd.dtbo
dtbo-y += sun-v2-ese-mtp.dtbo
dtbo-y += sun-v2-ese-cdp.dtbo
dtbo-y += sun-v2-ese-qrd.dtbo
endif

endif  #end of CONFIG_MMI_DEVICE_DTBS

always-y	:= $(dtb-y) $(dtbo-y)
subdir-y	:= $(dts-dirs)
clean-files	:= *.dtb *.dtbo
