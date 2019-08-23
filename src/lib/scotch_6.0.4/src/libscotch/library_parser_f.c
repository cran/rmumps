/* Copyright 2004,2007,2010,2014 IPB, Universite de Bordeaux, INRIA & CNRS
**
** This file is part of the Scotch software package for static mapping,
** graph partitioning and sparse matrix ordering.
**
** This software is governed by the CeCILL-C license under French law
** and abiding by the rules of distribution of free software. You can
** use, modify and/or redistribute the software under the terms of the
** CeCILL-C license as circulated by CEA, CNRS and INRIA at the following
** URL: "http://www.cecill.info".
** 
** As a counterpart to the access to the source code and rights to copy,
** modify and redistribute granted by the license, users are provided
** only with a limited warranty and the software's author, the holder of
** the economic rights, and the successive licensors have only limited
** liability.
** 
** In this respect, the user's attention is drawn to the risks associated
** with loading, using, modifying and/or developing or reproducing the
** software by the user in light of its specific status of free software,
** that may mean that it is complicated to manipulate, and that also
** therefore means that it is reserved for developers and experienced
** professionals having in-depth computer knowledge. Users are therefore
** encouraged to load and test the software's suitability as regards
** their requirements in conditions enabling the security of their
** systems and/or data to be ensured and, more generally, to use and
** operate it in the same conditions as regards security.
** 
** The fact that you are presently reading this means that you have had
** knowledge of the CeCILL-C license and that you accept its terms.
*/
/************************************************************/
/**                                                        **/
/**   NAME       : library_parser_f.c                      **/
/**                                                        **/
/**   AUTHOR     : Francois PELLEGRINI                     **/
/**                                                        **/
/**   FUNCTION   : This module is the Fortran API for the  **/
/**                strategy handling routines of the       **/
/**                libSCOTCH library.                      **/
/**                                                        **/
/**   DATES      : # Version 4.0  : from : 17 jan 2004     **/
/**                                 to     17 mar 2005     **/
/**                # Version 5.1  : from : 27 mar 2010     **/
/**                                 to     27 mar 2010     **/
/**                # Version 6.0  : from : 07 jan 2014     **/
/**                                 to     07 jan 2014     **/
/**                                                        **/
/************************************************************/

/*
**  The defines and includes.
*/

#define LIBRARY

#include "module.h"
#include "common.h"
#include "parser.h"
#include "scotch.h"

/***************************************/
/*                                     */
/* These routines are the Fortran API  */
/* for the ordering handling routines. */
/*                                     */
/***************************************/

FORTRAN (                                       \
SCOTCHFSTRATINIT, scotchfstratinit, (           \
double * const        stratptr,           \
int * const                 revaptr),           \
(stratptr, revaptr))
{
  *revaptr = SCOTCH_stratInit ((SCOTCH_Strat *) stratptr); /* ssg */
}

/*
**
*/

FORTRAN (                                       \
SCOTCHFSTRATEXIT, scotchfstratexit, (           \
double * const        stratptr),          \
(stratptr))
{
  SCOTCH_stratExit ((SCOTCH_Strat *) stratptr); /* ssg */
}

/*
**
*/

FORTRAN (                                       \
SCOTCHFSTRATFREE, scotchfstratfree, (           \
SCOTCH_Strat * const        stratptr),          \
(stratptr))
{
  SCOTCH_stratFree (stratptr);
}

/*
**
*/

FORTRAN (                                       \
SCOTCHFSTRATSAVE, scotchfstratsave, (           \
const SCOTCH_Strat * const  stratptr,           \
int * const                 fileptr,            \
int * const                 revaptr),           \
(stratptr, fileptr, revaptr))
{
  FILE *              stream;                     /* Stream to build from handle */
  int                 filenum;                    /* Duplicated handle           */
  int                 o;

  if ((filenum = dup (*fileptr)) < 0) {           /* If cannot duplicate file descriptor */
    errorPrint ("SCOTCHFSTRATSAVE: cannot duplicate handle");

    *revaptr = 1;                                 /* Indicate error */
    return;
  }
  if ((stream = fdopen (filenum, "w")) == NULL) { /* Build stream from handle */
    errorPrint ("SCOTCHFSTRATSAVE: cannot open output stream");
    close      (filenum);
    *revaptr = 1;
    return;
  }

  o = SCOTCH_stratSave (stratptr, stream);

  fclose (stream);                                /* This closes filenum too */

  *revaptr = o;
}
