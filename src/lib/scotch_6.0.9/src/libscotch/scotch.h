/* Copyright 2004,2007-2012,2014-2016,2018,2019 IPB, Universite de Bordeaux, INRIA & CNRS
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
/**   NAME       : scotch.h                                **/
/**                                                        **/
/**   AUTHOR     : Francois PELLEGRINI                     **/
/**                Jun-Ho HER (v6.0)                       **/
/**                Sebastien FOURESTIER (v6.0)             **/
/**                                                        **/
/**   FUNCTION   : Declaration file for the LibScotch      **/
/**                static mapping and sparse matrix block  **/
/**                ordering library.                       **/
/**                                                        **/
/**   DATES      : # Version 3.2  : from : 07 sep 1996     **/
/**                                 to     22 aug 1998     **/
/**                # Version 3.3  : from : 02 oct 1998     **/
/**                                 to     31 may 1999     **/
/**                # Version 3.4  : from : 10 oct 1999     **/
/**                                 to     15 nov 2001     **/
/**                # Version 4.0  : from : 11 dec 2001     **/
/**                                 to     20 dec 2005     **/
/**                # Version 5.0  : from : 26 apr 2006     **/
/**                                 to   : 20 feb 2008     **/
/**                # Version 5.1  : from : 30 nov 2007     **/
/**                                 to   : 07 aug 2011     **/
/**                # Version 6.0  : from : 12 sep 2008     **/
/**                                 to     24 sep 2019     **/
/**                                                        **/
/************************************************************/

#ifndef SCOTCH_H
#define SCOTCH_H

/*
**  The type and structure definitions.
*/

/*+ Integer type. +*/

typedef int32_t SCOTCH_Idx;

typedef int32_t SCOTCH_Num;

#define SCOTCH_NUMMAX               ((int32_t) (((uint32_t) 1 << ((sizeof (int32_t) << 3) - 1)) - 1))
#define SCOTCH_NUMSTRING            "%d"

/*+ Version flags. +*/

#if ((! defined SCOTCH_H_UNIQUE) && (! defined SCOTCH_RENAME_ALL))
#define SCOTCH_VERSION 6
#define SCOTCH_RELEASE 0
#define SCOTCH_PATCHLEVEL 9
#else /* ((! defined SCOTCH_H_UNIQUE) && (! defined SCOTCH_RENAME_ALL)) */
#if ((SCOTCH_VERSION != 6) || (SCOTCH_RELEASE != 0) || (SCOTCH_PATCHLEVEL != 9))
#ifndef SCOTCH_WARNING_RENAME_UNSAFE
#define SCOTCH_WARNING_RENAME_UNSAFE
#endif /* SCOTCH_WARNING_RENAME_UNSAFE */
#endif /* ((SCOTCH_VERSION != 6) || (SCOTCH_RELEASE != 0) || (SCOTCH_PATCHLEVEL != 9)) */
#endif /* SCOTCH_H_UNIQUE */

/*+ Coarsening flags +*/

#ifndef SCOTCH_COARSENNONE
#define SCOTCH_COARSENNONE          0x0000
#define SCOTCH_COARSENFOLD          0x0100
#define SCOTCH_COARSENFOLDDUP       0x0300
#define SCOTCH_COARSENNOMERGE       0x4000
#endif /* SCOTCH_COARSENNONE */

/*+ Strategy string parametrization values +*/

#ifndef SCOTCH_STRATDEFAULT
#define SCOTCH_STRATDEFAULT         0x00000
#define SCOTCH_STRATQUALITY         0x00001
#define SCOTCH_STRATSPEED           0x00002
#define SCOTCH_STRATBALANCE         0x00004
#define SCOTCH_STRATSAFETY          0x00008
#define SCOTCH_STRATSCALABILITY     0x00010
#define SCOTCH_STRATRECURSIVE       0x00100
#define SCOTCH_STRATREMAP           0x00200
#define SCOTCH_STRATLEVELMAX        0x01000
#define SCOTCH_STRATLEVELMIN        0x02000
#define SCOTCH_STRATLEAFSIMPLE      0x04000
#define SCOTCH_STRATSEPASIMPLE      0x08000
#define SCOTCH_STRATDISCONNECTED    0x10000
#endif /* SCOTCH_STRATDEFAULT */

/*+ Opaque objects. The dummy sizes of these
objects, computed at compile-time by program
"dummysizes", are given as double values for
proper padding                               +*/

#ifndef SCOTCH_H_UNIQUE
typedef unsigned char       SCOTCH_GraphPart2;
#endif /* SCOTCH_H_UNIQUE */

typedef struct {
  double                    dummy[11];
} SCOTCH_Arch;

typedef struct {
  double                    dummy[5];
} SCOTCH_ArchDom;

typedef struct {
  double                    dummy[2];
} SCOTCH_Geom;

typedef struct {
  double                    dummy[13];
} SCOTCH_Graph;

typedef struct {
  double                    dummy[15];
} SCOTCH_Mesh;

typedef struct {
  double                    dummy[4];
} SCOTCH_Mapping;

typedef struct {
  double                    dummy[12];
} SCOTCH_Ordering;

typedef struct {
  double                    dummy[1];
} SCOTCH_Strat;

/*
**  The function prototypes.
*/

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

SCOTCH_Arch *               SCOTCH_archAlloc    (void);
int                         SCOTCH_archInit     (SCOTCH_Arch * const);
void                        SCOTCH_archExit     (SCOTCH_Arch * const);
int                         SCOTCH_archLoad     (SCOTCH_Arch * const, FILE * const);
int                         SCOTCH_archSave     (const SCOTCH_Arch * const, FILE * const);
int                         SCOTCH_archBuild    (SCOTCH_Arch * const, const SCOTCH_Graph * const, const SCOTCH_Num, const SCOTCH_Num * const, const SCOTCH_Strat * const);
int                         SCOTCH_archBuild0   (SCOTCH_Arch * const, const SCOTCH_Graph * const, const SCOTCH_Num, const SCOTCH_Num * const, const SCOTCH_Strat * const);
int                         SCOTCH_archBuild2   (SCOTCH_Arch * const, const SCOTCH_Graph * const, const SCOTCH_Num, const SCOTCH_Num * const);
char *                      SCOTCH_archName     (const SCOTCH_Arch * const);
SCOTCH_Num                  SCOTCH_archSize     (const SCOTCH_Arch * const);
int                         SCOTCH_archVar      (const SCOTCH_Arch * const);
int                         SCOTCH_archCmplt    (SCOTCH_Arch * const, const SCOTCH_Num);
int                         SCOTCH_archCmpltw   (SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num * const);
int                         SCOTCH_archHcub     (SCOTCH_Arch * const, const SCOTCH_Num);
int                         SCOTCH_archMesh2    (SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num);
int                         SCOTCH_archMesh3    (SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num, const SCOTCH_Num);
int                         SCOTCH_archMeshX    (SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num * const);
int                         SCOTCH_archSub      (SCOTCH_Arch * const, SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num * const);

int                         SCOTCH_archTleaf    (SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num * const, const SCOTCH_Num * const);
int                         SCOTCH_archTorus2   (SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num);
int                         SCOTCH_archTorus3   (SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num, const SCOTCH_Num);
int                         SCOTCH_archTorusX   (SCOTCH_Arch * const, const SCOTCH_Num, const SCOTCH_Num * const);
int                         SCOTCH_archVcmplt   (SCOTCH_Arch * const);
int                         SCOTCH_archVhcub    (SCOTCH_Arch * const);

SCOTCH_Num                  SCOTCH_archDomNum   (SCOTCH_Arch * const, const SCOTCH_ArchDom * const);
int                         SCOTCH_archDomTerm  (SCOTCH_Arch * const, SCOTCH_ArchDom * const, const SCOTCH_Num);
SCOTCH_Num                  SCOTCH_archDomSize  (SCOTCH_Arch * const, const SCOTCH_ArchDom * const);
SCOTCH_Num                  SCOTCH_archDomWght  (SCOTCH_Arch * const, const SCOTCH_ArchDom * const);
SCOTCH_Num                  SCOTCH_archDomDist  (SCOTCH_Arch * const, const SCOTCH_ArchDom * const, const SCOTCH_ArchDom * const);
int                         SCOTCH_archDomFrst  (SCOTCH_Arch * const, SCOTCH_ArchDom * const);
int                         SCOTCH_archDomBipart (SCOTCH_Arch * const, const SCOTCH_ArchDom * const, SCOTCH_ArchDom * const, SCOTCH_ArchDom * const);

void                        SCOTCH_errorProg    (const char * const);
void                        SCOTCH_errorPrint   (const char * const, ...);
void                        SCOTCH_errorPrintW  (const char * const, ...);

SCOTCH_Geom *               SCOTCH_geomAlloc    (void);
int                         SCOTCH_geomInit     (SCOTCH_Geom * const);
void                        SCOTCH_geomExit     (SCOTCH_Geom * const);
void                        SCOTCH_geomData     (const SCOTCH_Geom * const, SCOTCH_Num * const, double ** const);

SCOTCH_Graph *              SCOTCH_graphAlloc   (void);
int                         SCOTCH_graphInit    (SCOTCH_Graph * const);
void                        SCOTCH_graphExit    (SCOTCH_Graph * const);
void                        SCOTCH_graphFree    (SCOTCH_Graph * const);
int                         SCOTCH_graphLoad    (SCOTCH_Graph * const, FILE * const, const SCOTCH_Num, const SCOTCH_Num);
int                         SCOTCH_graphSave    (const SCOTCH_Graph * const, FILE * const);
int                         SCOTCH_graphBuild   (SCOTCH_Graph * const, const SCOTCH_Num, const SCOTCH_Num, const SCOTCH_Num * const, const SCOTCH_Num * const, const SCOTCH_Num * const, const SCOTCH_Num * const, const SCOTCH_Num, const SCOTCH_Num * const, const SCOTCH_Num * const);
SCOTCH_Num                  SCOTCH_graphBase    (SCOTCH_Graph * const, const SCOTCH_Num);
int                         SCOTCH_graphCheck   (const SCOTCH_Graph * const);
int                         SCOTCH_graphCoarsen (const SCOTCH_Graph * const, const SCOTCH_Num, const double, const SCOTCH_Num, SCOTCH_Graph * const, SCOTCH_Num * const);
int                         SCOTCH_graphCoarsenMatch (const SCOTCH_Graph * const, SCOTCH_Num * const, const double, const SCOTCH_Num, SCOTCH_Num * const);
int                         SCOTCH_graphCoarsenBuild (const SCOTCH_Graph * const, const SCOTCH_Num, SCOTCH_Num * const, SCOTCH_Graph * const, SCOTCH_Num * const);
int                         SCOTCH_graphColor   (const SCOTCH_Graph * const, SCOTCH_Num * const, SCOTCH_Num * const, const SCOTCH_Num);
void                        SCOTCH_graphData    (const SCOTCH_Graph * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num ** const, SCOTCH_Num ** const, SCOTCH_Num ** const, SCOTCH_Num ** const, SCOTCH_Num * const, SCOTCH_Num ** const, SCOTCH_Num ** const);
void                        SCOTCH_graphSize    (const SCOTCH_Graph * const, SCOTCH_Num * const, SCOTCH_Num * const);
void                        SCOTCH_graphStat    (const SCOTCH_Graph * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, double * const, double * const, SCOTCH_Num * const, SCOTCH_Num * const, double * const, double * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, double * const, double * const);
SCOTCH_Num                  SCOTCH_graphDiamPV  (const SCOTCH_Graph * const);
int                         SCOTCH_graphGeomLoadChac (SCOTCH_Graph * const, SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_graphGeomLoadHabo (SCOTCH_Graph * const, SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_graphGeomLoadMmkt (SCOTCH_Graph * const, SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_graphGeomLoadScot (SCOTCH_Graph * const, SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_graphGeomSaveChac (const SCOTCH_Graph * const, const SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_graphGeomSaveMmkt (const SCOTCH_Graph * const, const SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_graphGeomSaveScot (const SCOTCH_Graph * const, const SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_graphInduceList (const SCOTCH_Graph * const, const SCOTCH_Num, const SCOTCH_Num * const, SCOTCH_Graph * const);
int                         SCOTCH_graphInducePart (const SCOTCH_Graph * const, const SCOTCH_Num, const SCOTCH_GraphPart2 * const, const SCOTCH_GraphPart2, SCOTCH_Graph * const);

int                         SCOTCH_graphMapInit (const SCOTCH_Graph * const, SCOTCH_Mapping * const, const SCOTCH_Arch * const, SCOTCH_Num * const);
void                        SCOTCH_graphMapExit (const SCOTCH_Graph * const, SCOTCH_Mapping * const);
int                         SCOTCH_graphMapLoad (const SCOTCH_Graph * const, SCOTCH_Mapping * const, FILE * const);
int                         SCOTCH_graphMapSave (const SCOTCH_Graph * const, const SCOTCH_Mapping * const, FILE * const);
int                         SCOTCH_graphMapCompute (SCOTCH_Graph * const, SCOTCH_Mapping * const, SCOTCH_Strat * const);
int                         SCOTCH_graphMapFixedCompute (SCOTCH_Graph * const, SCOTCH_Mapping * const, SCOTCH_Strat * const);
int                         SCOTCH_graphMap     (SCOTCH_Graph * const, const SCOTCH_Arch * const, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphMapFixed (SCOTCH_Graph * const, const SCOTCH_Arch * const, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphMapView (const SCOTCH_Graph * const, const SCOTCH_Mapping * const, FILE * const);
int                         SCOTCH_graphPart    (SCOTCH_Graph * const, const SCOTCH_Num, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphPartFixed (SCOTCH_Graph * const, const SCOTCH_Num, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphPartOvl (SCOTCH_Graph * const, const SCOTCH_Num, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphPartOvlView (const SCOTCH_Graph * const, const SCOTCH_Num, const SCOTCH_Num * const, FILE * const);
int                         SCOTCH_graphRemap   (SCOTCH_Graph * const, const SCOTCH_Arch * const, SCOTCH_Num *, const double, const SCOTCH_Num *, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphRemapFixed (SCOTCH_Graph * const, const SCOTCH_Arch * const, SCOTCH_Num *, const double, const SCOTCH_Num *, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphRemapCompute (SCOTCH_Graph * const, SCOTCH_Mapping * const, SCOTCH_Mapping * const, const double, const SCOTCH_Num *, SCOTCH_Strat * const);
int                         SCOTCH_graphRemapFixedCompute (SCOTCH_Graph * const, SCOTCH_Mapping * const, SCOTCH_Mapping * const, const double, const SCOTCH_Num *, SCOTCH_Strat * const);
int                         SCOTCH_graphRemapView (const SCOTCH_Graph * const, const SCOTCH_Mapping * const, const SCOTCH_Mapping * const, const double, SCOTCH_Num *, FILE * const);
int                         SCOTCH_graphRemapViewRaw (const SCOTCH_Graph * const, const SCOTCH_Mapping * const, const SCOTCH_Mapping * const, const double, SCOTCH_Num *, FILE * const);
int                         SCOTCH_graphRepart  (SCOTCH_Graph * const, const SCOTCH_Num, SCOTCH_Num * const, const double, const SCOTCH_Num *, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphRepartFixed (SCOTCH_Graph * const, const SCOTCH_Num, SCOTCH_Num * const, const double, const SCOTCH_Num *, SCOTCH_Strat * const, SCOTCH_Num * const);
int                         SCOTCH_graphTabLoad (const SCOTCH_Graph * const, SCOTCH_Num * const, FILE * const);
int                         SCOTCH_graphTabSave (const SCOTCH_Graph * const, const SCOTCH_Num * const, FILE * const);
  
int                         SCOTCH_graphOrderInit (const SCOTCH_Graph * const, SCOTCH_Ordering * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const);
void                        SCOTCH_graphOrderExit (const SCOTCH_Graph * const, SCOTCH_Ordering * const);
int                         SCOTCH_graphOrderLoad (const SCOTCH_Graph * const, SCOTCH_Ordering * const, FILE * const);
int                         SCOTCH_graphOrderSave (const SCOTCH_Graph * const, const SCOTCH_Ordering * const, FILE * const);
int                         SCOTCH_graphOrderSaveMap (const SCOTCH_Graph * const, const SCOTCH_Ordering * const, FILE * const);
int                         SCOTCH_graphOrderSaveTree (const SCOTCH_Graph * const, const SCOTCH_Ordering * const, FILE * const);
int                         SCOTCH_graphOrderCompute (SCOTCH_Graph * const, SCOTCH_Ordering * const, SCOTCH_Strat * const);
int                         SCOTCH_graphOrderComputeList (SCOTCH_Graph * const, SCOTCH_Ordering * const, const SCOTCH_Num, const SCOTCH_Num * const, SCOTCH_Strat * const);
int                         SCOTCH_graphOrderFactor (const SCOTCH_Graph * const, const SCOTCH_Ordering * const, SCOTCH_Graph * const);
int                         SCOTCH_graphOrderView (const SCOTCH_Graph * const, const SCOTCH_Ordering * const, FILE * const);
int                         SCOTCH_graphOrder   (SCOTCH_Graph * const, SCOTCH_Strat * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const);
int                         SCOTCH_graphOrderList (SCOTCH_Graph * const, const SCOTCH_Num, const SCOTCH_Num * const, SCOTCH_Strat * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const);
int                         SCOTCH_graphOrderCheck (const SCOTCH_Graph * const, const SCOTCH_Ordering * const);

SCOTCH_Mapping *            SCOTCH_mapAlloc     (void);

void                        SCOTCH_memFree      (void * const);
SCOTCH_Idx                  SCOTCH_memCur       (void);
SCOTCH_Idx                  SCOTCH_memMax       (void);

int                         SCOTCH_meshInit     (SCOTCH_Mesh * const);
void                        SCOTCH_meshExit     (SCOTCH_Mesh * const);
int                         SCOTCH_meshLoad     (SCOTCH_Mesh * const, FILE * const, const SCOTCH_Num);
int                         SCOTCH_meshSave     (const SCOTCH_Mesh * const, FILE * const);
int                         SCOTCH_meshBuild    (SCOTCH_Mesh * const, const SCOTCH_Num, const SCOTCH_Num, const SCOTCH_Num, const SCOTCH_Num, const SCOTCH_Num * const, const SCOTCH_Num * const, const SCOTCH_Num * const, const SCOTCH_Num * const, const SCOTCH_Num * const, const SCOTCH_Num, const SCOTCH_Num * const);
int                         SCOTCH_meshCheck    (const SCOTCH_Mesh * const);
void                        SCOTCH_meshSize     (const SCOTCH_Mesh * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const);
void                        SCOTCH_meshData     (const SCOTCH_Mesh * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num ** const, SCOTCH_Num ** const, SCOTCH_Num ** const, SCOTCH_Num ** const, SCOTCH_Num ** const, SCOTCH_Num * const, SCOTCH_Num ** const, SCOTCH_Num * const);
void                        SCOTCH_meshStat     (const SCOTCH_Mesh * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, double * const, double * const, SCOTCH_Num * const, SCOTCH_Num * const, double * const, double * const, SCOTCH_Num * const, SCOTCH_Num * const, double * const, double * const);
int                         SCOTCH_meshGraph    (const SCOTCH_Mesh * const, SCOTCH_Graph * const);
int                         SCOTCH_meshGeomLoadHabo (SCOTCH_Mesh * const, SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_meshGeomLoadScot (SCOTCH_Mesh * const, SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);
int                         SCOTCH_meshGeomSaveScot (const SCOTCH_Mesh * const, const SCOTCH_Geom * const, FILE * const, FILE * const, const char * const);

int                         SCOTCH_meshOrderInit (const SCOTCH_Mesh * const, SCOTCH_Ordering * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const);
void                        SCOTCH_meshOrderExit (const SCOTCH_Mesh * const, SCOTCH_Ordering * const);
int                         SCOTCH_meshOrderSave (const SCOTCH_Mesh * const, const SCOTCH_Ordering * const, FILE * const);
int                         SCOTCH_meshOrderSaveMap (const SCOTCH_Mesh * const, const SCOTCH_Ordering * const, FILE * const);
int                         SCOTCH_meshOrderSaveTree (const SCOTCH_Mesh * const, const SCOTCH_Ordering * const, FILE * const);
int                         SCOTCH_meshOrderCompute (SCOTCH_Mesh * const, SCOTCH_Ordering * const, SCOTCH_Strat * const);
int                         SCOTCH_meshOrderComputeList (SCOTCH_Mesh * const, SCOTCH_Ordering * const, const SCOTCH_Num, const SCOTCH_Num * const, SCOTCH_Strat * const);
int                         SCOTCH_meshOrder    (SCOTCH_Mesh * const, SCOTCH_Strat * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const);
int                         SCOTCH_meshOrderList (SCOTCH_Mesh * const, const SCOTCH_Num, const SCOTCH_Num * const, SCOTCH_Strat * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const, SCOTCH_Num * const);
int                         SCOTCH_meshOrderCheck (const SCOTCH_Mesh * const, const SCOTCH_Ordering * const);

int                         SCOTCH_numSizeof    (void);

SCOTCH_Ordering *           SCOTCH_orderAlloc   (void);

int                         SCOTCH_randomLoad   (FILE *);
int                         SCOTCH_randomSave   (FILE *);
void                        SCOTCH_randomProc   (int);
void                        SCOTCH_randomReset  (void);
void                        SCOTCH_randomSeed   (SCOTCH_Num);

SCOTCH_Strat *              SCOTCH_stratAlloc   (void);
int                         SCOTCH_stratInit    (SCOTCH_Strat * const);
void                        SCOTCH_stratExit    (SCOTCH_Strat * const);
void                        SCOTCH_stratFree    (SCOTCH_Strat * const);
int                         SCOTCH_stratSave    (const SCOTCH_Strat * const, FILE * const);
int                         SCOTCH_stratGraphBipart (SCOTCH_Strat * const, const char * const);
int                         SCOTCH_stratGraphMap (SCOTCH_Strat * const, const char * const);
int                         SCOTCH_stratGraphMapBuild (SCOTCH_Strat * const, const SCOTCH_Num, const SCOTCH_Num, const double);
int                         SCOTCH_stratGraphClusterBuild (SCOTCH_Strat * const, const SCOTCH_Num, const SCOTCH_Num, const double, const double);
int                         SCOTCH_stratGraphPartOvl (SCOTCH_Strat * const, const char * const);
int                         SCOTCH_stratGraphPartOvlBuild (SCOTCH_Strat * const, const SCOTCH_Num, const SCOTCH_Num, const double);
int                         SCOTCH_stratGraphOrder (SCOTCH_Strat * const, const char * const);
int                         SCOTCH_stratGraphOrderBuild (SCOTCH_Strat * const, const SCOTCH_Num, const SCOTCH_Num, const double);
int                         SCOTCH_stratMeshOrder (SCOTCH_Strat * const, const char * const);
int                         SCOTCH_stratMeshOrderBuild (SCOTCH_Strat * const, const SCOTCH_Num, const double);

void                        SCOTCH_version      (int * const, int * const, int * const);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#define SCOTCH_H_UNIQUE                           /* For symbols that need only be defined once */
#endif /* SCOTCH_H */
