#==============================================================================
#
# Makefile for Diff_TauProfile program
#
#==============================================================================

# Define macros
include $(CRTM_SOURCE_ROOT)/make.macros

# This makefile
MAKE_FILE = Makefile

# Executable file
EXE_FILE = Diff_TauProfile

# Source files to link
SRC_FILES = Type_Kinds.f90 \
            File_Utility.f90 \
            Message_Handler.f90 \
            Compare_Float_Numbers.f90 \
            netCDF_Utility.f90 \
            netCDF_Dimension_Utility.f90 \
            netCDF_Attribute_Utility.f90 \
            netCDF_Variable_Utility.f90 \
            TauProfile_Define.f90 \
            TauProfile_netCDF_IO.f90

# Obj files used in link phase
OBJ_FILES = ${SRC_FILES:.f90=.o} \
            $(EXE_FILE).o

# Include and library definitions
NETCDF_DIR = $(HOME)/local/netcdf
INCLUDES = -I$(NETCDF_DIR)/include
LIBRARIES = -L$(NETCDF_DIR)/lib -lnetcdf


# ------------------
# Define dependecies
# ------------------
include $(CRTM_SOURCE_ROOT)/make.common_targets

# Source link creation and removal
create_links:
	@linkfiles $(CRTM_SOURCE_ROOT) $(SRC_FILES)

remove_links:
	@unlinkfiles $(SRC_FILES)

realclean: clean remove_links

# Source dependency lists
include make.dependencies


# --------------------
# Define default rules
# --------------------
include $(CRTM_SOURCE_ROOT)/make.rules

