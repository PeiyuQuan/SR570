TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += sr570Support

# Compile and add code to the support library
sr570Support_SRCS += xxxRecord.c
sr570Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
sr570Support_SRCS += dbSubExample.c
sr570Support_SRCS += devsr570Version.c
sr570Support_SRCS += sr570Hello.c
sr570Support_SRCS += initTrace.c

sr570Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = sr570Version.h
# Macro name
GENVERSIONMACRO = sr570VERSION

# Build the IOC application
PROD_IOC = sr570

# sr570.dbd will be created and installed
DBD += sr570.dbd

# sr570.dbd will include these files:
sr570_DBD += base.dbd
sr570_DBD += xxxSupport.dbd
sr570_DBD += dbSubExample.dbd
sr570_DBD += devsr570Version.dbd
sr570_DBD += sr570Hello.dbd
sr570_DBD += initTrace.dbd
sr570_DBD += asyn.dbd
sr570_DBD += drvAsynIPPort.dbd
sr570_DBD += drvAsynSerialPort.dbd
sr570_DBD += calc.dbd
sr570_DBD += stream-scalcout.dbd
sr570_DBD += stream.dbd
sr570_DBD += as.dbd
sr570_DBD += asSupport.dbd



# sr570_registerRecordDeviceDriver.cpp derives from sr570.dbd
sr570_SRCS += sr570_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
sr570_SRCS_DEFAULT += sr570Main.cpp
sr570_SRCS_vxWorks += -nil-

# Link in the code from our support library
sr570_LIBS += sr570Support
sr570_LIBS += asyn
sr570_LIBS += calc
sr570_LIBS += autosave
sr570_LIBS += stream

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into sr570Support
    sncExample_SNCFLAGS += +r
    sr570_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    sr570Support_SRCS += sncExample.stt
    sr570Support_LIBS += seq pv
    sr570_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    sr570_LIBS += qsrv
    sr570_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    sr570_DBD += PVAServerRegister.dbd
    sr570_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
sr570_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devsr570Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
