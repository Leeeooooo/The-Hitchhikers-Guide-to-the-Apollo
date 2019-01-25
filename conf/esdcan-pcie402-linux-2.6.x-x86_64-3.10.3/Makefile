#########################################################################
# FILE NAME Makefile
#           copyright 2002 by esd electronic system design GmbH
#
# BRIEF MODULE DESCRIPTION
# 	    Makefile for ESDCAN-release-package
#
#
# History:
#
#  23.07.2002 - initial version (based on MFs-makefiles in esdcan) ab
#
#########################################################################
#  Copyright (c) 1996 - 2002 by electronic system design gmbh
#
#  This software is copyrighted by and is the sole property of
#  esd gmbh.  All rights, title, ownership, or other interests
#  in the software remain the property of esd gmbh. This
#  software may only be used in accordance with the corresponding
#  license agreement.  Any unauthorized use, duplication, transmission,
#  distribution, or disclosure of this software is expressly forbidden.
#
#  This Copyright notice may not be removed or modified without prior
#  written consent of esd gmbh.
#
#  esd gmbh, reserves the right to modify this software without notice.
#
#  electronic system design gmbh          Tel. +49-511-37298-0
#  Vahrenwalder Str 207                   Fax. +49-511-37298-68
#  30165 Hannover                         http://www.esd-electronics.com
#  Germany                                sales@esd-electronics.com
#
#########################################################################
include ./config.mk

# DO NOT TOUCH THE NEXT LINE!
DRVVERSION=

INSTROOT    = /

ifeq ($(TARGET_ARCH),ppc)
ifdef CROSS_COMPILE
CROSS      = $(CROSS_COMPILE)
else
CROSS      = ppc_4xx-
endif
endif

CC	   = $(CROSS)gcc
LD	   = $(CROSS)ld
STRIP	   = $(CROSS)strip

BLD_PATH = ./src/
BLDOBJECTS = *.o *.mod.c *.ko.cmd *.ko .tmp_versions .*.cmd

VPATH = $(BLD_PATH)

INCL = -I$(VPATH) -I./lib32

CFLAGS     = $(INCL) -I$(KERNELPATH)/include $(SPECIAL)
CFLAGS    += -Wall -Wstrict-prototypes -fomit-frame-pointer
CFLAGS    += -O2

ifeq ($(TARGET_OS),linux)
CFLAGS    += -DOSIF_OS_LINUX
endif

ifeq ($(TARGET_OS),linuxrtai)
CFLAGS    += -DOSIF_OS_RTAI
endif

ifeq ($(TARGET_ARCH),ppc)
CFLAGS    += -DOSIF_ARCH_PPC -I$(KERNELPATH)/arch/$(TARGET_ARCH)
# kernel 2.6 cross compilation requires ARCH= argument
# do not forget to set CROSS_COMPILE correctly!
# Note: export ARCH in your shell before building!
KERNELARCH =
endif

ifeq ($(TARGET_ARCH),x86)
CFLAGS    += -DOSIF_ARCH_X86
endif

ifeq ($(TARGET_ARCH),arm)
CFLAGS    += -DOSIF_ARCH_ARM
endif


VERSION := $(shell echo -e "\#include <linux/version.h>\nint r=UTS_RELEASE" | $(CC) -I$(KERNELPATH)/include -E - | grep "int r" | sed s/int\ r=// | sed s/\ //)

DRVNAME  = esdcan-$(BOARD)-$(TARGET_OS)-$(TARGET_ARCH)-$(VERSION)

INSTDRV  = $(INSTROOT)/lib/modules/$(VERSION)
INSTBIN  = $(INSTROOT)/usr/bin
INSTLIB  = $(INSTROOT)/usr/lib

PWD := $(shell pwd)

all:
	$(MAKE) -C $(KERNELPATH) $(KERNELARCH) SUBDIRS=$(PWD)/src ESDCAN_FLAGS=$(ESDCAN_FLAGS) modules
	@echo "Please do not forget to create nodes for the can-device in /dev/!"

liblinks:
	@cd ./lib32; \
	test -L libntcan.so.3 || ln -s ./libntcan.so.3.* ./libntcan.so.3; \
	test -L libntcan.so || ln -s ./libntcan.so.3 ./libntcan.so

cantest: example/cantest.c lib32/ntcan.h liblinks
	$(CC) $(CFLAGS) -L./lib32/ $(INCL) -o bin32/$@ $< -lntcan

cantest_static: example/cantest.c lib32/ntcan.h lib32/libntcan.a
	$(CC) $(CFLAGS) -static -L./lib32/ $(INCL) -o bin32/$@ $< -lntcan

clean:
	for t in $(BLDOBJECTS); do \
		rm -rf $(BLD_PATH)$${t}; \
	done
	rm -f *~ $(DRVNAME)

FORCE:
