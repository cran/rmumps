/*
 *
 *  This file is part of MUMPS 5.3.5, released
 *  on Thu Oct 22 09:29:08 UTC 2020
 *
 *
 *  Copyright 1991-2020 CERFACS, CNRS, ENS Lyon, INP Toulouse, Inria,
 *  Mumps Technologies, University of Bordeaux.
 *
 *  This version of MUMPS is provided to you free of charge. It is
 *  released under the CeCILL-C license 
 *  (see doc/CeCILL-C_V1-en.txt, doc/CeCILL-C_V1-fr.txt, and
 *  https://cecill.info/licences/Licence_CeCILL-C_V1-en.html)
 *
 */
/* Utility to automatically get the sizes of Fortran types */
#include "mumps_size.h"
void  MUMPS_CALL MUMPS_SIZE_C(void *a, void *b, MUMPS_INT8 *diff)
{
    *diff = (MUMPS_INT8) ((intptr_t)b - (intptr_t)a);
}
void MUMPS_CALL MUMPS_ADDR_C(void *a, MUMPS_INT8 *addr)
{
union {
    void ** aa;
    MUMPS_INT8* a8;
} x;
x.aa=&a;
*addr=*(x.a8);
/* *addr=*(MUMPS_INT8*)(&a);*/ /* ssg */
/*
    With the form "*addr=(MUMPS_INT8)a", "(MUMPS_INT8)a"
    and "a" may have different binary representations
    for large addresses. In the aboce code, "(MUMPS_INT8*)&a"
    is a pointer to the address "a", considering that "a" is
    a MUMPS_INT8 rather than an address. Then the content of
    that pointer is the exact binary representation of the
    address a, but stored in a MUMPS_INT8 (signed 64-bit
    integer).
*/
}
