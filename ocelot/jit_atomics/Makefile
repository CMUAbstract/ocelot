LIB = librustic

OBJECTS += \
  runtime.o \

override SRC_ROOT = ../../src

override CFLAGS += \
	-I$(SRC_ROOT)/include/$(LIB) \

ifeq ($(LIBRUSTIC_CLANG_ISR), 1)
LOCAL_CFLAGS += -DLIBRUSTIC_CLANGISR
endif

override CFLAGS += $(LOCAL_CFLAGS)

include $(MAKER_ROOT)/Makefile.$(TOOLCHAIN)
