# CESM build flags for:
#   Compiler = gnu:
#   Machine = roo2:
#   OS = Mac OS X:

# ==================================================
# pFUnit location.
# ==================================================

list(APPEND CMAKE_PREFIX_PATH /Users/leo/pFUnit_MPI_install )
include(Compilers)

# ==================================================
# Flags needed for linking netcdf (needed for some drv unit tests)
# ==================================================

set(NETCDF_DIR "/usr/local")

# The following is a hack to get cmake to link in hdf5, because there does not
# appear to be a find package script for hdf5:
set(CMAKE_EXE_LINKER_FLAGS "-lhdf5_hl")
include_directories("/opt/local/include")
link_directories("/opt/local/lib")
# The following commented out lines did not work in terms of finding an hdf5 library:
# set(HDF5_DIR "/usr/local")
# set(CMAKE_PREFIX_PATH "/usr/local")
#
# Interestingly, the link step works without the above lines if I get
# -L/usr/local/Cellar/netcdf/4.3.2_1/lib -lnetcdff -L/usr/local/Cellar/netcdf/4.3.2_1/lib -lnetcdf -lnetcdf
# on the link line, but the default link line from FindNETCDF instead has
# /usr/local/lib/libnetcdff.a /usr/local/lib/libnetcdf.a
# (Sean Santos thinks that the dynamic libraries point to the correct hdf5
# library, whereas the static libraries do not.)

# The following is needed so that the above include_directories are listed after
# any include_directories specified by the top-level CMakeLists.txt
set(CMAKE_INCLUDE_DIRECTORIES_BEFORE ON)


# ==================================================
# CPP definitions.
# ==================================================

add_config_definitions(CESM  -DFORTRANUNDERSCORE -DNO_R16)
add_config_definitions(CESM  -DHAVE_NANOTIME )
add_config_definitions(CESM_DEBUG  -DFORTRANUNDERSCORE -DNO_R16)
add_config_definitions(CESM_DEBUG  -DHAVE_NANOTIME )
add_definitions(-DSYSDARWIN)

# ==================================================
# Fortran flags.
# ==================================================
add_flags(CMAKE_Fortran_FLAGS_CESM -fopenmp -fconvert=big-endian -ffree-line-length-none -ffixed-line-length-none)
add_flags(CMAKE_Fortran_FLAGS_CESM  -O2 )
add_flags(CMAKE_Fortran_FLAGS_CESM_DEBUG -fopenmp -fconvert=big-endian -ffree-line-length-none -ffixed-line-length-none -fno-range-check -fall-intrinsics -ffpe-trap=zero,overflow -fcheck=bounds)
add_flags(CMAKE_Fortran_FLAGS_CESM_DEBUG  -O0 -g)

# ==================================================
# C flags.
# ==================================================

add_flags(CMAKE_C_FLAGS_CESM -fopenmp -O2)
add_flags(CMAKE_C_FLAGS_CESM_DEBUG -fopenmp -O0)

# ==================================================
# Linker flags.
# ==================================================
