CXX = g++

SRCDIR=./
COMMDIR=./webrtc_main
NSDIR=./ns
SIGNDIR=./ns_base
RESAMPLE=./resample
CCFILES += \
		$(NSDIR)/noise_suppression_x.c \
		$(COMMDIR)/main.c \
		$(NSDIR)/nsx_core.c \
		$(NSDIR)/real_fft.c \
		$(SIGNDIR)/spl_init.c \
		$(SIGNDIR)/copy_set_operations.c \
		$(SIGNDIR)/division_operations.c \
		$(SIGNDIR)/energy.c \
		$(SIGNDIR)/spl_sqrt_floor.c \
		$(SIGNDIR)/complex_bit_reverse.c \
		$(SIGNDIR)/complex_fft.c \
		$(SIGNDIR)/min_max_operations.c \
		$(SIGNDIR)/cross_correlation.c \
		$(SIGNDIR)/downsample_fast.c \
		$(SIGNDIR)/vector_scaling_operations.c \
		$(SIGNDIR)/get_scaling_square.c \
		$(RESAMPLE)/resample_48khz.c \
		$(RESAMPLE)/resample_by_2.c \
		$(RESAMPLE)/resample.c \
		$(RESAMPLE)/resample_by_2_internal.c \
		$(RESAMPLE)/resample_fractional.c \
		$(COMMDIR)/nsx_main.c \

HFILES += \
		$(NSDIR)/windows_private.h \
		$(SRCDIR)/hal_trace.h \
		$(NSDIR)/typedefs.h \
		$(NSDIR)/cpu_features_wrapper.h \
		$(NSDIR)/nsx_core.h \
		$(NSDIR)/defines.h \
		$(NSDIR)/nsx_defines.h \
		$(NSDIR)/noise_suppression_x.h \
		$(NSDIR)/signal_processing_library.h \
		$(NSDIR)/real_fft.h \
		$(COMMDIR)/nsx_main.h \
		$(RESAMPLE)/resample.h \
		$(RESAMPLE)/resample_by_2_internal.h \
		$(NSDIR)/spl_inl.h 

LD_FLAGS         = -lm 

LD_LIBS          = 

#DEFS             = -DSTATIC_MEM -DWEBRTC_NSX -DNSX_CODE_UNUSE=1
DEFS             = -DSTATIC_MEM -DWEBRTC_NSX -DRESAMPLER=1

OBJS             += $(patsubst %.c,%.c.o, $(CCFILES))

CFLAGS           =  -g -O0 -m64 -Wall

CFLAGS            += $(DEFS)

EXECUTABLE       = webrtc

INCLUDE_FLAGS    = -I$(SRCDIR) -I$(COMMDIR) -I$(NSDIR) -I$(AGCDIR) -I$(VADDIR)
#INCLUDE_FLAGS    = -I$(SRCDIR) -I$(COMMDIR) -I$(AGCDIR) -I$(VADDIR)

## Each subdirectory must supply rules for building sources it contributes
all: $(OBJS) $(CCFILES)
	$(CXX) -o $(EXECUTABLE) $(CFLAGS) $(OBJS) $(LD_FLAGS) 


$(OBJS): $(CCFILES) $(HFILES)
	$(CXX) $(CFLAGS) $(INCLUDE_FLAGS) -o $@ -c $*


.phony: clean


clean:
	@rm -f $(OBJS) $(EXECUTABLE)
