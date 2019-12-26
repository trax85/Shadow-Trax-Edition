# C flags
cflags-y	+= -os
obj-y           += msm_sleeper.o
obj-$(CONFIG_BRICKED_HOTPLUG)		+= bricked_hotplug.o
obj-$(CONFIG_MAKO_HOTPLUG)              += mako_hotplug.o
obj-$(CONFIG_ALESSA_PLUG)		+= Alessa_Plug.o
obj-$(CONFIG_INTELLI_PLUG)              += intelli_plug.o
obj-$(CONFIG_MSM_HOTPLUG)		+= msm_hotplug.o
obj-$(CONFIG_ALUCARD_HOTPLUG)           += alucard_hotplug.o
obj-$(CONFIG_LAZYPLUG)			+= lazyplug.o
CFLAGS_lazyplug.o			+= -finline-functions

