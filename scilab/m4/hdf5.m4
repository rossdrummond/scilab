dnl
dnl Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
dnl Copyright (C) DIGITEO - 2009 - 2009 - Bruno JOFRET
dnl 
dnl This file must be used under the terms of the CeCILL.
dnl This source file is licensed as described in the file COPYING, which
dnl you should have received as part of this distribution.  The terms
dnl are also available at    
dnl http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
dnl
dnl libhdf5 is mandatory in Scilab 
dnl When we check :
dnl * if the path is provided or that we have to find it ourself
dnl * if it is available
dnl * what are the compilation flags 
dnl * what are linking flags
AC_DEFUN([AC_HDF5], [

saved_cflags=$CFLAGS
saved_LIBS="$LIBS"
		
HDF5_CFLAGS=""
HDF5_LIBS="-lhdf5"

CFLAGS="$CFLAGS $HDF5_CFLAGS"
LIBS="$LIBS $HDF5_LIBS"

AC_CHECK_HEADER([hdf5.h],
                [HDF5_CFLAGS="$CFLAGS"],
                [AC_MSG_ERROR([Cannot find headers (hdf5.h) of the library HDF5. Please install the dev package])]
        )

AC_CHECK_LIB([hdf5], [H5Dopen],
               [],
               [AC_MSG_ERROR([libhdf5: library missing. (Cannot find symbol H5Dopen). Check if libhdf5 is installed and if the version is correct])]
               )
CFLAGS=$saved_cflags
LIBS="$saved_LIBS"

AC_SUBST(HDF5_CFLAGS)
AC_SUBST(HDF5_LIBS)

AC_DEFINE_UNQUOTED([HDF5_CFLAGS],["$HDF5_CFLAGS"],[HDF5 cflags])
AC_DEFINE_UNQUOTED([HDF5_LIBS],["$HDF5_LIBS"],[HDF5 library])

AC_DEFINE([WITH_HDF5], [], [With the HDF5 library])

# Gets compilation and library flags
])