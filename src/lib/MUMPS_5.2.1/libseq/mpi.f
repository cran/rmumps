C
C  This file is part of MUMPS 5.2.1, released
C  on Fri Jun 14 14:46:05 UTC 2019
C
C
C  Copyright 1991-2019 CERFACS, CNRS, ENS Lyon, INP Toulouse, Inria,
C  Mumps Technologies, University of Bordeaux.
C
C  This version of MUMPS is provided to you free of charge. It is
C  released under the CeCILL-C license:
C  http://www.cecill.info/licences/Licence_CeCILL-C_V1-en.html
C
C******************************************************************
C
C  This file contains dummy MPI/BLACS/ScaLAPACK libraries to allow
C  linking/running MUMPS on a platform where MPI is not installed.
C
C******************************************************************
C
C MPI
C
C******************************************************************
C ssg
      SUBROUTINE MPI_NOOP()
      RETURN
      END SUBROUTINE MPI_NOOP

      SUBROUTINE MPI_BSEND( BUF, CNT, DATATYPE, DEST, TAG, COMM,
     &            IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, DATATYPE, DEST, TAG, COMM, IERR
      INTEGER BUF(*)
C      WRITE(*,*) 'Error. MPI_BSEND should not be called.'
C      STOP
      call rexit('Error. MPI_BSEND should not be called.')
      IERR = 0
      RETURN
      END SUBROUTINE MPI_BSEND
C***********************************************************************
      SUBROUTINE MPI_BUFFER_ATTACH(BUF, CNT,  IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, IERR
      INTEGER BUF(*)
      IERR = 0
      RETURN
      END SUBROUTINE MPI_BUFFER_ATTACH
C***********************************************************************
      SUBROUTINE MPI_BUFFER_DETACH(BUF, CNT,  IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, IERR
      INTEGER BUF(*)
           IERR = 0
      RETURN
      END SUBROUTINE MPI_BUFFER_DETACH
      SUBROUTINE MPI_GATHER( SENDBUF, CNT, 
     &         DATATYPE, RECVBUF, RECCNT, RECTYPE,
     &         ROOT, COMM, IERR )
      IMPLICIT NONE
      INTEGER CNT, DATATYPE, RECCNT, RECTYPE, ROOT, COMM, IERR
      INTEGER SENDBUF(*), RECVBUF(*)
      IF ( RECCNT .NE. CNT ) THEN
C        WRITE(*,*) 'ERROR in MPI_GATHER, RECCNT != CNT'
C        STOP
        call rexit('ERROR in MPI_GATHER, RECCNT != CNT')
      ELSE
        CALL MUMPS_COPY( CNT, SENDBUF, RECVBUF, DATATYPE, IERR )
        IF ( IERR .NE. 0 ) THEN
C          WRITE(*,*) 'ERROR in MPI_GATHER, DATATYPE=',DATATYPE
C          STOP
           call rexit('ERROR in MPI_GATHER, DATATYPE=')
        END IF
      END IF
      IERR = 0
      RETURN
      END SUBROUTINE MPI_GATHER
C***********************************************************************
      SUBROUTINE MPI_GATHERV( SENDBUF, CNT, 
     &         DATATYPE, RECVBUF, RECCNT, DISPLS, RECTYPE,
     &         ROOT, COMM, IERR )
      IMPLICIT NONE
      INTEGER CNT, DATATYPE, RECTYPE, ROOT, COMM, IERR
      INTEGER RECCNT(1)
      INTEGER SENDBUF(*), RECVBUF(*)
      INTEGER DISPLS(*)
C
C     Note that DISPLS is ignored in this version. One may
C     want to copy in reception buffer with a shift DISPLS(1).
C     This requires passing the offset DISPLS(1) to
C     "MUMPS_COPY_DATATYPE" routines.
C
      IF ( RECCNT(1) .NE. CNT ) THEN
C        WRITE(*,*) 'ERROR in MPI_GATHERV, RECCNT(1) != CNT'
C        STOP
        call rexit('ERROR in MPI_GATHERV, RECCNT(1) != CNT')
      ELSE
        CALL MUMPS_COPY( CNT, SENDBUF, RECVBUF, DATATYPE, IERR )
        IF ( IERR .NE. 0 ) THEN
C          WRITE(*,*) 'ERROR in MPI_GATHERV, DATATYPE=',DATATYPE
C          STOP
          call rexit('ERROR in MPI_GATHERV, DATATYPE=')
        END IF
      END IF
      IERR = 0
      RETURN
      END SUBROUTINE MPI_GATHERV
C***********************************************************************
      SUBROUTINE MPI_ALLREDUCE( SENDBUF, RECVBUF, CNT, DATATYPE,
     &                          OPERATION, COMM, IERR )
      IMPLICIT NONE
      INTEGER CNT, DATATYPE, OPERATION, COMM, IERR
      INTEGER SENDBUF(*), RECVBUF(*)
      LOGICAL, EXTERNAL :: MUMPS_IS_IN_PLACE
      IF (.NOT. MUMPS_IS_IN_PLACE(SENDBUF, CNT)) THEN
        CALL MUMPS_COPY( CNT, SENDBUF, RECVBUF, DATATYPE, IERR )
        IF ( IERR .NE. 0 ) THEN
C          WRITE(*,*) 'ERROR in MPI_ALLREDUCE, DATATYPE=',DATATYPE
C          STOP
          call rexit('ERROR in MPI_ALLREDUCE, DATATYPE=')
        END IF
      ENDIF
      IERR = 0
      RETURN
      END SUBROUTINE MPI_ALLREDUCE
C***********************************************************************
      SUBROUTINE MPI_REDUCE( SENDBUF, RECVBUF, CNT, DATATYPE, OP,
     &           ROOT, COMM, IERR )
      IMPLICIT NONE
      INTEGER CNT, DATATYPE, OP, ROOT, COMM, IERR
      INTEGER SENDBUF(*), RECVBUF(*)
      LOGICAL, EXTERNAL :: MUMPS_IS_IN_PLACE
      IF (.NOT. MUMPS_IS_IN_PLACE(SENDBUF, CNT)) THEN
        CALL MUMPS_COPY( CNT, SENDBUF, RECVBUF, DATATYPE, IERR )
        IF ( IERR .NE. 0 ) THEN
C          WRITE(*,*) 'ERROR in MPI_REDUCE, DATATYPE=',DATATYPE
C          STOP
          call rexit('ERROR in MPI_REDUCE, DATATYPE=')
        END IF
      ENDIF
      IERR = 0
      RETURN
      END SUBROUTINE MPI_REDUCE
C***********************************************************************
C ssg
      SUBROUTINE MPI_REDUCE_D( SENDBUF, RECVBUF, CNT, DATATYPE, OP,
     &           ROOT, COMM, IERR )
      IMPLICIT NONE
      INTEGER CNT, DATATYPE, OP, ROOT, COMM, IERR
      DOUBLE PRECISION SENDBUF(*), RECVBUF(*)
      LOGICAL, EXTERNAL :: MUMPS_IS_IN_PLACE
      CALL MUMPS_COPY_DOUBLE_PRECISION(SENDBUF, RECVBUF, CNT)
      IERR = 0
      RETURN
      END SUBROUTINE MPI_REDUCE_D
C***********************************************************************
      SUBROUTINE MPI_REDUCE_SCATTER( SENDBUF, RECVBUF, RCVCNT, 
     &           DATATYPE, OP, COMM, IERR )
      IMPLICIT NONE
      INTEGER RCVCNT, DATATYPE, OP, COMM, IERR
      INTEGER SENDBUF(*), RECVBUF(*)
      LOGICAL, EXTERNAL :: MUMPS_IS_IN_PLACE
      IF (.NOT. MUMPS_IS_IN_PLACE(SENDBUF, RCVCNT)) THEN
        CALL MUMPS_COPY( RCVCNT, SENDBUF, RECVBUF, DATATYPE, IERR )
        IF ( IERR .NE. 0 ) THEN
C          WRITE(*,*) 'ERROR in MPI_REDUCE_SCATTER, DATATYPE=',DATATYPE
C          STOP
          call rexit('ERROR in MPI_REDUCE_SCATTER, DATATYPE=')
        END IF
      ENDIF
      IERR = 0
      RETURN
      END SUBROUTINE MPI_REDUCE_SCATTER
C***********************************************************************
      SUBROUTINE MPI_ABORT( COMM, IERRCODE, IERR )
      IMPLICIT NONE
      INTEGER COMM, IERRCODE, IERR
C      WRITE(*,*) "** MPI_ABORT called"
C      STOP
      call rexit("** MPI_ABORT called")
      END SUBROUTINE MPI_ABORT
C***********************************************************************
      SUBROUTINE MPI_ALLTOALL( SENDBUF, SENDCNT, SENDTYPE,
     &                         RECVBUF, RECVCNT, RECVTYPE, COMM, IERR )
      IMPLICIT NONE
      INTEGER SENDCNT, SENDTYPE, RECVCNT, RECVTYPE, COMM, IERR
      INTEGER SENDBUF(*), RECVBUF(*)
      IF ( RECVCNT .NE. SENDCNT ) THEN
C        WRITE(*,*) 'ERROR in MPI_ALLTOALL, RECVCNT != SENDCNT'
C        STOP
        call rexit('ERROR in MPI_ALLTOALL, RECVCNT != SENDCNT')
      ELSE IF ( RECVTYPE .NE. SENDTYPE ) THEN
C        WRITE(*,*) 'ERROR in MPI_ALLTOALL, RECVTYPE != SENDTYPE'
C        STOP
        call rexit('ERROR in MPI_ALLTOALL, RECVTYPE != SENDTYPE')
      ELSE
        CALL MUMPS_COPY( SENDCNT, SENDBUF, RECVBUF, SENDTYPE, IERR )
        IF ( IERR .NE. 0 ) THEN
C          WRITE(*,*) 'ERROR in MPI_ALLTOALL, SENDTYPE=',SENDTYPE
C          STOP
          call rexit('ERROR in MPI_ALLTOALL, SENDTYPE=')
        END IF
      END IF
      IERR = 0
      RETURN
      END SUBROUTINE MPI_ALLTOALL
C***********************************************************************
      SUBROUTINE MPI_ATTR_PUT( COMM, KEY, VAL, IERR )
      IMPLICIT NONE
      INTEGER COMM, KEY, VAL, IERR
      RETURN
      END SUBROUTINE MPI_ATTR_PUT
C***********************************************************************
      SUBROUTINE MPI_BARRIER( COMM, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER COMM, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_BARRIER
C***********************************************************************
      SUBROUTINE MPI_GET_PROCESSOR_NAME( NAME, RESULTLEN, IERROR)
      CHARACTER (LEN=*) NAME
      INTEGER RESULTLEN,IERROR
      RESULTLEN = 1
      IERROR = 0
      NAME = 'X'
      RETURN
      END SUBROUTINE MPI_GET_PROCESSOR_NAME
C***********************************************************************
      SUBROUTINE MPI_BCAST( BUFFER, CNT, DATATYPE, ROOT, COMM, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, DATATYPE, ROOT, COMM, IERR
      INTEGER BUFFER( * )
      IERR = 0
      RETURN
      END SUBROUTINE MPI_BCAST
C***********************************************************************
      SUBROUTINE MPI_CANCEL( IREQ, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER IREQ, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_CANCEL
C***********************************************************************
      SUBROUTINE MPI_COMM_CREATE( COMM, GROUP, COMM2, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER COMM, GROUP, COMM2, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_COMM_CREATE
C***********************************************************************
      SUBROUTINE MPI_COMM_DUP( COMM, COMM2, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER COMM, COMM2, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_COMM_DUP
C***********************************************************************
      SUBROUTINE MPI_COMM_FREE( COMM, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER COMM, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_COMM_FREE
C***********************************************************************
      SUBROUTINE MPI_COMM_GROUP( COMM, GROUP, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER COMM, GROUP, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_COMM_GROUP
C***********************************************************************
      SUBROUTINE MPI_COMM_RANK( COMM, RANK, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER COMM, RANK, IERR
      RANK = 0
      IERR = 0
      RETURN
      END SUBROUTINE MPI_COMM_RANK
C***********************************************************************
      SUBROUTINE MPI_COMM_SIZE( COMM, SIZE, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER COMM, SIZE, IERR
      SIZE = 1
      IERR = 0
      RETURN
      END SUBROUTINE MPI_COMM_SIZE
C***********************************************************************
      SUBROUTINE MPI_COMM_SPLIT( COMM, COLOR, KEY, COMM2, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER COMM, COLOR, KEY, COMM2, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_COMM_SPLIT
C***********************************************************************
c     SUBROUTINE MPI_ERRHANDLER_SET( COMM, ERRHANDLER, IERR )
c     IMPLICIT NONE
c     INCLUDE 'mpif.h'
c     INTEGER COMM, ERRHANDLER, IERR
c     IERR = 0
c     RETURN
c     END SUBROUTINE MPI_ERRHANDLER_SET
C***********************************************************************
      SUBROUTINE MPI_FINALIZE( IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_FINALIZE
C***********************************************************************
      SUBROUTINE MPI_GET_COUNT( STATUS, DATATYPE, CNT, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER DATATYPE, CNT, IERR
      INTEGER STATUS( MPI_STATUS_SIZE )
C      WRITE(*,*) 'Error. MPI_GET_CNT should not be called.'
C      STOP
      call rexit('Error. MPI_GET_CNT should not be called.')
      IERR = 0
      RETURN
      END SUBROUTINE MPI_GET_COUNT
C***********************************************************************
      SUBROUTINE MPI_GROUP_FREE( GROUP, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER GROUP, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_GROUP_FREE
C***********************************************************************
      SUBROUTINE MPI_GROUP_RANGE_EXCL( GROUP, N, RANGES, GROUP2, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER GROUP, N, GROUP2, IERR
      INTEGER RANGES(*)
      IERR = 0
      RETURN
      END SUBROUTINE MPI_GROUP_RANGE_EXCL
C***********************************************************************
      SUBROUTINE MPI_GROUP_SIZE( GROUP, SIZE, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER GROUP, SIZE, IERR
      SIZE = 1 ! Or should it be zero ?
      IERR = 0
      RETURN
      END SUBROUTINE MPI_GROUP_SIZE
C***********************************************************************
      SUBROUTINE MPI_INIT(IERR)
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_INIT
C***********************************************************************
      SUBROUTINE MPI_INITIALIZED( FLAG, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      LOGICAL FLAG
      INTEGER IERR
      FLAG = .TRUE.
      IERR = 0
      RETURN
      END SUBROUTINE MPI_INITIALIZED
C***********************************************************************
      SUBROUTINE MPI_IPROBE( SOURCE, TAG, COMM, FLAG, STATUS, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER SOURCE, TAG, COMM, IERR
      INTEGER STATUS(MPI_STATUS_SIZE)
      LOGICAL FLAG
      FLAG = .FALSE.
      IERR = 0
      RETURN
      END SUBROUTINE MPI_IPROBE
C***********************************************************************
      SUBROUTINE MPI_IRECV( BUF, CNT, DATATYPE, SOURCE, TAG, COMM,
     &           IREQ, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, DATATYPE, SOURCE, TAG, COMM, IREQ, IERR
      INTEGER BUF(*)
      IERR = 0
      RETURN
      END SUBROUTINE MPI_IRECV
C***********************************************************************
      SUBROUTINE MPI_ISEND( BUF, CNT, DATATYPE, DEST, TAG, COMM,
     &           IREQ, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, DATATYPE, DEST, TAG, COMM, IERR, IREQ
      INTEGER BUF(*)
C      WRITE(*,*) 'Error. MPI_ISEND should not be called.'
C      STOP
      call rexit('Error. MPI_ISEND should not be called.')
      IERR = 0
      RETURN
      END SUBROUTINE MPI_ISEND
C***********************************************************************
      SUBROUTINE MPI_TYPE_COMMIT( NEWTYP, IERR_MPI )
      IMPLICIT NONE
      INTEGER NEWTYP, IERR_MPI
      RETURN
      END SUBROUTINE MPI_TYPE_COMMIT
C***********************************************************************
      SUBROUTINE MPI_TYPE_FREE( NEWTYP, IERR_MPI )
      IMPLICIT NONE
      INTEGER NEWTYP, IERR_MPI
      RETURN
      END SUBROUTINE MPI_TYPE_FREE
C***********************************************************************
      SUBROUTINE MPI_TYPE_CONTIGUOUS( LENGTH, DATATYPE, NEWTYPE,
     &                                IERR_MPI )
      IMPLICIT NONE
      INTEGER LENGTH, DATATYPE, NEWTYPE, IERR_MPI
      RETURN
      END SUBROUTINE MPI_TYPE_CONTIGUOUS
C***********************************************************************
      SUBROUTINE MPI_OP_CREATE( FUNC, COMMUTE, OP, IERR )
      IMPLICIT NONE
      EXTERNAL FUNC
      LOGICAL COMMUTE
      INTEGER OP, IERR
      OP = 0
      RETURN
      END SUBROUTINE MPI_OP_CREATE
C***********************************************************************
      SUBROUTINE MPI_OP_FREE( OP, IERR )
      IMPLICIT NONE
      INTEGER OP, IERR
      RETURN
      END SUBROUTINE MPI_OP_FREE
C***********************************************************************
      SUBROUTINE MPI_PACK( INBUF, INCNT, DATATYPE, OUTBUF, OUTCNT,
     &           POSITION, COMM, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER INCNT, DATATYPE, OUTCNT, POSITION, COMM, IERR
      INTEGER INBUF(*), OUTBUF(*)
C      WRITE(*,*) 'Error. MPI_PACKED should not be called.'
C      STOP
      call rexit('Error. MPI_PACKED should not be called.')
      IERR = 0
      RETURN
      END SUBROUTINE MPI_PACK
C***********************************************************************
      SUBROUTINE MPI_PACK_SIZE( INCNT, DATATYPE, COMM, SIZE, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER INCNT, DATATYPE, COMM, SIZE, IERR
C      WRITE(*,*) 'Error. MPI_PACK_SIZE should not be called.'
C      STOP
      call rexit('Error. MPI_PACK_SIZE should not be called.')
      IERR = 0
      RETURN
      END SUBROUTINE MPI_PACK_SIZE
C***********************************************************************
      SUBROUTINE MPI_PROBE( SOURCE, TAG, COMM, STATUS, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER SOURCE, TAG, COMM, IERR
      INTEGER STATUS( MPI_STATUS_SIZE )
C      WRITE(*,*) 'Error. MPI_PROBE should not be called.'
C      STOP
      call rexit('Error. MPI_PROBE should not be called.')
      IERR = 0
      RETURN
      END SUBROUTINE MPI_PROBE
C***********************************************************************
      SUBROUTINE MPI_RECV( BUF, CNT, DATATYPE, SOURCE, TAG, COMM,
     &           STATUS, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, DATATYPE, SOURCE, TAG, COMM, IERR
      INTEGER BUF(*), STATUS(MPI_STATUS_SIZE)
C      WRITE(*,*) 'Error. MPI_RECV should not be called.'
C      STOP
      call rexit('Error. MPI_RECV should not be called.')
      IERR = 0
      RETURN
      END SUBROUTINE MPI_RECV
C***********************************************************************
      SUBROUTINE MPI_REQUEST_FREE( IREQ, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER IREQ, IERR
      IERR = 0
      RETURN
      END SUBROUTINE MPI_REQUEST_FREE
C***********************************************************************
      SUBROUTINE MPI_SEND( BUF, CNT, DATATYPE, DEST, TAG, COMM, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, DATATYPE, DEST, TAG, COMM, IERR
      INTEGER BUF(*)
C      WRITE(*,*) 'Error. MPI_SEND should not be called.'
      call rexit('Error. MPI_SEND should not be called.')
C      STOP
      IERR = 0
      RETURN
      END SUBROUTINE MPI_SEND
C***********************************************************************
      SUBROUTINE MPI_SSEND( BUF, CNT, DATATYPE, DEST, TAG, COMM, IERR)
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, DATATYPE, DEST, TAG, COMM, IERR
      INTEGER BUF(*)
C      WRITE(*,*) 'Error. MPI_SSEND should not be called.'
      call rexit('Error. MPI_SSEND should not be called.')
C      STOP
      IERR = 0
      RETURN
      END SUBROUTINE MPI_SSEND
C***********************************************************************
      SUBROUTINE MPI_TEST( IREQ, FLAG, STATUS, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER IREQ, IERR
      INTEGER STATUS( MPI_STATUS_SIZE )
      LOGICAL FLAG
      FLAG = .FALSE.
      IERR = 0
      RETURN
      END SUBROUTINE MPI_TEST
C***********************************************************************
      SUBROUTINE MPI_UNPACK( INBUF, INSIZE, POSITION, OUTBUF, OUTCNT,
     &           DATATYPE, COMM, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER INSIZE, POSITION, OUTCNT, DATATYPE, COMM, IERR
      INTEGER INBUF(*), OUTBUF(*)
C      WRITE(*,*) 'Error. MPI_UNPACK should not be called.'
      call rexit('Error. MPI_UNPACK should not be called.')
C      STOP
      IERR = 0
      RETURN
      END SUBROUTINE MPI_UNPACK
C***********************************************************************
      SUBROUTINE MPI_WAIT( IREQ, STATUS, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER IREQ, IERR
      INTEGER STATUS( MPI_STATUS_SIZE )
C      WRITE(*,*) 'Error. MPI_WAIT should not be called.'
      call rexit('Error. MPI_WAIT should not be called.')
C      STOP
      IERR = 0
      RETURN
      END SUBROUTINE MPI_WAIT
C***********************************************************************
      SUBROUTINE MPI_WAITALL( CNT, ARRAY_OF_REQUESTS, STATUS, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, IERR
      INTEGER STATUS( MPI_STATUS_SIZE )
      INTEGER ARRAY_OF_REQUESTS( CNT )
C      WRITE(*,*) 'Error. MPI_WAITALL should not be called.'
      call rexit('Error. MPI_WAITALL should not be called.')
C      STOP
      IERR = 0
      RETURN
      END SUBROUTINE MPI_WAITALL
C***********************************************************************
      SUBROUTINE MPI_WAITANY( CNT, ARRAY_OF_REQUESTS, INDEX, STATUS,
     &           IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, INDEX, IERR
      INTEGER STATUS( MPI_STATUS_SIZE )
      INTEGER ARRAY_OF_REQUESTS( CNT )
C      WRITE(*,*) 'Error. MPI_WAITANY should not be called.'
      call rexit('Error. MPI_WAITANY should not be called.')
C      STOP
      IERR = 0
      RETURN
      END SUBROUTINE MPI_WAITANY
C***********************************************************************
      DOUBLE PRECISION FUNCTION MPI_WTIME( )
C     elapsed time
      DOUBLE PRECISION VAL
C     write(*,*) 'Entering MPI_WTIME'
      CALL MUMPS_ELAPSE( VAL )
      MPI_WTIME = VAL
C     write(*,*) 'Exiting MPI_WTIME'
      RETURN
      END FUNCTION MPI_WTIME


C***********************************************************************
C
C  Utilities to copy data
C
C***********************************************************************

      SUBROUTINE MUMPS_COPY( CNT, SENDBUF, RECVBUF, DATATYPE, IERR )
      IMPLICIT NONE
      INCLUDE 'mpif.h'
      INTEGER CNT, DATATYPE, IERR
C      INTEGER SENDBUF(*), RECVBUF(*) ! ssg !
      INTEGER SENDBUF(*), RECVBUF(*), FACTOR, BASE
      LOGICAL VL
      REAL VR
      DOUBLE PRECISION VD
      COMPLEX VC
      COMPLEX(kind=kind(0.0D0)) :: VCD
      
      BASE=INT(SIZEOF(SENDBUF(1)))
      IF ( DATATYPE .EQ. MPI_INTEGER ) THEN
C         CALL MUMPS_COPY_INTEGER( SENDBUF, RECVBUF, CNT )
          FACTOR=BASE
      ELSEIF ( DATATYPE .EQ. MPI_LOGICAL ) THEN
C         CALL MUMPS_COPY_LOGICAL( SENDBUF, RECVBUF, CNT )
          FACTOR=INT(SIZEOF(VL))
      ELSE IF ( DATATYPE .EQ. MPI_REAL ) THEN
C         CALL MUMPS_COPY_REAL( SENDBUF, RECVBUF, CNT )
          FACTOR=INT(SIZEOF(VR))
      ELSE IF ( DATATYPE .EQ. MPI_DOUBLE_PRECISION .OR.
     &        DATATYPE .EQ. MPI_REAL8 ) THEN
C         CALL MUMPS_COPY_DOUBLE_PRECISION( SENDBUF, RECVBUF, CNT )
          FACTOR=INT(SIZEOF(VD))
      ELSE IF ( DATATYPE .EQ. MPI_COMPLEX ) THEN
C         CALL MUMPS_COPY_COMPLEX( SENDBUF, RECVBUF, CNT )
          FACTOR=INT(SIZEOF(VC))
      ELSE IF ( DATATYPE .EQ. MPI_DOUBLE_COMPLEX ) THEN
C         CALL MUMPS_COPY_DOUBLE_COMPLEX( SENDBUF, RECVBUF, CNT )
          FACTOR=INT(SIZEOF(VCD))
      ELSE IF ( DATATYPE .EQ. MPI_2DOUBLE_PRECISION) THEN
C         CALL MUMPS_COPY_2DOUBLE_PRECISION( SENDBUF, RECVBUF, CNT )
          FACTOR=INT(2*SIZEOF(VD))
      ELSE IF ( DATATYPE .EQ. MPI_2INTEGER) THEN
C         CALL MUMPS_COPY_2INTEGER( SENDBUF, RECVBUF, CNT )
          FACTOR=2*BASE
      ELSE IF ( DATATYPE .EQ. MPI_INTEGER8) THEN
C         CALL MUMPS_COPY_INTEGER8( SENDBUF, RECVBUF, CNT )
          FACTOR=2*BASE
      ELSE
        IERR=1
        RETURN
      END IF
      CALL MUMPS_COPY_INTEGER( SENDBUF, RECVBUF, (FACTOR/BASE)*CNT )
      IERR=0
      RETURN
      END SUBROUTINE MUMPS_COPY

      SUBROUTINE MUMPS_COPY_INTEGER( S, R, N )
      IMPLICIT NONE
      INTEGER N
      INTEGER S(N),R(N)
      INTEGER I
      DO I = 1, N
        R(I) = S(I)
      END DO
      RETURN
      END SUBROUTINE MUMPS_COPY_INTEGER
      SUBROUTINE MUMPS_COPY_INTEGER8( S, R, N )
      IMPLICIT NONE
      INTEGER N
      INTEGER(8) S(N),R(N)
      INTEGER I
      DO I = 1, N
        R(I) = S(I)
      END DO
      RETURN
      END SUBROUTINE MUMPS_COPY_INTEGER8
      SUBROUTINE MUMPS_COPY_LOGICAL( S, R, N )
      IMPLICIT NONE
      INTEGER N
      LOGICAL S(N),R(N)
      INTEGER I
      DO I = 1, N
        R(I) = S(I)
      END DO
      RETURN
      END
      SUBROUTINE MUMPS_COPY_2INTEGER( S, R, N )
      IMPLICIT NONE
      INTEGER N
      INTEGER S(N+N),R(N+N)
      INTEGER I
      DO I = 1, N+N
        R(I) = S(I)
      END DO
      RETURN
      END SUBROUTINE MUMPS_COPY_2INTEGER
      SUBROUTINE MUMPS_COPY_REAL( S, R, N )
      IMPLICIT NONE
      INTEGER N
      REAL S(N),R(N)
      INTEGER I
      DO I = 1, N
        R(I) = S(I)
      END DO
      RETURN
      END
      SUBROUTINE MUMPS_COPY_2DOUBLE_PRECISION( S, R, N )
      IMPLICIT NONE
      INTEGER N
      DOUBLE PRECISION S(N+N),R(N+N)
      INTEGER I
      DO I = 1, N+N
        R(I) = S(I)
      END DO
      RETURN
      END SUBROUTINE MUMPS_COPY_2DOUBLE_PRECISION
      SUBROUTINE MUMPS_COPY_DOUBLE_PRECISION( S, R, N )
      IMPLICIT NONE
      INTEGER N
      DOUBLE PRECISION S(N),R(N)
      INTEGER I
      DO I = 1, N
        R(I) = S(I)
      END DO
      RETURN
      END
      SUBROUTINE MUMPS_COPY_COMPLEX( S, R, N )
      IMPLICIT NONE
      INTEGER N
      COMPLEX S(N),R(N)
      INTEGER I
      DO I = 1, N
        R(I) = S(I)
      END DO
      RETURN
      END SUBROUTINE MUMPS_COPY_COMPLEX
      SUBROUTINE MUMPS_COPY_DOUBLE_COMPLEX( S, R, N )
      IMPLICIT NONE
      INTEGER N
C     DOUBLE COMPLEX S(N),R(N)
      COMPLEX(kind=kind(0.0D0)) :: S(N),R(N)
      INTEGER I
      DO I = 1, N
        R(I) = S(I)
      END DO
      RETURN
      END
      LOGICAL FUNCTION MUMPS_IS_IN_PLACE( SENDBUF, CNT )
      INTEGER SENDBUF(*), CNT
      LOGICAL, EXTERNAL :: MUMPS_CHECK_EQUAL
      INCLUDE 'mpif.h'
C     Instead of checking the address, we modify the value
C     of MPI_IN_PLACE, to check if SENDBUF = MPI_IN_PLACE.
      MUMPS_IS_IN_PLACE = .FALSE.
      IF ( CNT .GT. 0 ) THEN
        MPI_IN_PLACE = -1
        IF (SENDBUF(1) .EQ. MPI_IN_PLACE) THEN
          MPI_IN_PLACE = -9876543
          IF (MUMPS_CHECK_EQUAL(SENDBUF(1), MPI_IN_PLACE)) THEN
            MUMPS_IS_IN_PLACE = .TRUE.
          ENDIF
        ENDIF
      ENDIF
      RETURN
      END FUNCTION MUMPS_IS_IN_PLACE
      LOGICAL FUNCTION MUMPS_CHECK_EQUAL(I,J)
      INTEGER :: I,J
      IF (I.EQ.J) THEN
        MUMPS_CHECK_EQUAL = .TRUE. 
      ELSE
        MUMPS_CHECK_EQUAL = .FALSE. 
      ENDIF
      END FUNCTION MUMPS_CHECK_EQUAL



C***********************************************************************
C
C     BLACS
C
C***********************************************************************
      SUBROUTINE blacs_gridinit( CNTXT, C, NPROW, NPCOL )
      IMPLICIT NONE
      INTEGER CNTXT, NPROW, NPCOL
      CHARACTER C
C        WRITE(*,*) 'Error. BLACS_GRIDINIT should not be called.'
        call rexit('Error. BLACS_GRIDINIT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE blacs_gridinit
C***********************************************************************
      SUBROUTINE blacs_gridinfo( CNTXT, NPROW, NPCOL, MYROW, MYCOL )
      IMPLICIT NONE
      INTEGER CNTXT, NPROW, NPCOL, MYROW, MYCOL
C        WRITE(*,*) 'Error. BLACS_GRIDINFO should not be called.'
        call rexit('Error. BLACS_GRIDINFO should not be called.')
C        STOP
      RETURN
      END SUBROUTINE blacs_gridinfo
C***********************************************************************
      SUBROUTINE blacs_gridexit( CNTXT )
      IMPLICIT NONE
      INTEGER CNTXT
C        WRITE(*,*) 'Error. BLACS_GRIDEXIT should not be called.'
        call rexit('Error. BLACS_GRIDEXIT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE blacs_gridexit


C***********************************************************************
C
C     ScaLAPACK
C
C***********************************************************************
      SUBROUTINE DESCINIT( DESC, M, N, MB, NB, IRSRC, ICSRC,
     &           ICTXT, LLD, INFO )
      IMPLICIT NONE
      INTEGER ICSRC, ICTXT, INFO, IRSRC, LLD, M, MB, N, NB
      INTEGER DESC( * )
C        WRITE(*,*) 'Error. DESCINIT should not be called.'
        call rexit('Error. DESCINIT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE DESCINIT
C***********************************************************************
      INTEGER FUNCTION numroc( N, NB, IPROC, ISRCPROC, NPROCS ) 
      INTEGER N, NB, IPROC, ISRCPROC, NPROCS
C     Can be called
      IF ( NPROCS .ne. 1 ) THEN
C        WRITE(*,*) 'Error. Last parameter from NUMROC should be 1'
        call rexit('Error. Last parameter from NUMROC should be 1')
C        STOP
      ENDIF
      IF ( IPROC .ne. 0 ) THEN
C        WRITE(*,*) 'Error. IPROC should be 0 in NUMROC.'
        call rexit('Error. IPROC should be 0 in NUMROC.')
C        STOP
      ENDIF
      NUMROC = N
      RETURN
      END FUNCTION numroc
C***********************************************************************
      SUBROUTINE pcpotrf( UPLO, N, A, IA, JA, DESCA, INFO )
      IMPLICIT NONE
      CHARACTER          UPLO
      INTEGER            IA, INFO, JA, N
      INTEGER            DESCA( * )
      COMPLEX            A( * )
C        WRITE(*,*) 'Error. PCPOTRF should not be called.'
        call rexit('Error. PCPOTRF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcpotrf
C***********************************************************************
      SUBROUTINE pcgetrf( M, N, A, IA, JA, DESCA, IPIV, INFO )
      IMPLICIT NONE
      INTEGER            IA, INFO, JA, M, N
      INTEGER            DESCA( * ), IPIV( * )
      COMPLEX            A( * )
C        WRITE(*,*) 'Error. PCGETRF should not be called.'
        call rexit('Error. PCGETRF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcgetrf
C***********************************************************************
      SUBROUTINE pctrtrs( UPLO, TRANS, DIAG, N, NRHS, A, IA, JA, DESCA,
     &                    B, IB, JB, DESCB, INFO )
      IMPLICIT NONE
      CHARACTER          DIAG, TRANS, UPLO
      INTEGER            IA, IB, INFO, JA, JB, N, NRHS
      INTEGER            DESCA( * ), DESCB( * )
      COMPLEX            A( * ), B( * )
C        WRITE(*,*) 'Error. PCTRTRS should not be called.'
        call rexit('Error. PCTRTRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pctrtrs
C***********************************************************************
      SUBROUTINE pzpotrf( UPLO, N, A, IA, JA, DESCA, INFO )
      IMPLICIT NONE
      CHARACTER          UPLO
      INTEGER            IA, INFO, JA, N
      INTEGER            DESCA( * )
C     DOUBLE COMPLEX     A( * )
      COMPLEX(kind=kind(0.0D0)) ::     A( * )
C        WRITE(*,*) 'Error. PZPOTRF should not be called.'
        call rexit('Error. PZPOTRF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzpotrf
C***********************************************************************
      SUBROUTINE pzgetrf( M, N, A, IA, JA, DESCA, IPIV, INFO )
      IMPLICIT NONE
      INTEGER            IA, INFO, JA, M, N
      INTEGER            DESCA( * ), IPIV( * )
C     DOUBLE COMPLEX     A( * )
      COMPLEX(kind=kind(0.0D0)) ::     A( * )
C        WRITE(*,*) 'Error. PZGETRF should not be called.'
        call rexit('Error. PZGETRF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzgetrf
C***********************************************************************
      SUBROUTINE pztrtrs( UPLO, TRANS, DIAG, N, NRHS, A, IA, JA, DESCA,
     &                    B, IB, JB, DESCB, INFO )
      IMPLICIT NONE
      CHARACTER          DIAG, TRANS, UPLO
      INTEGER            IA, IB, INFO, JA, JB, N, NRHS
      INTEGER            DESCA( * ), DESCB( * )
C     DOUBLE COMPLEX     A( * ), B( * )
      COMPLEX(kind=kind(0.0D0)) ::     A( * ), B( * )
C        WRITE(*,*) 'Error. PZTRTRS should not be called.'
        call rexit('Error. PZTRTRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pztrtrs
C***********************************************************************
      SUBROUTINE pspotrf( UPLO, N, A, IA, JA, DESCA, INFO )
      IMPLICIT NONE
      CHARACTER          UPLO
      INTEGER            IA, INFO, JA, N
      INTEGER            DESCA( * )
      REAL               A( * )
C        WRITE(*,*) 'Error. PSPOTRF should not be called.'
        call rexit('Error. PSPOTRF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pspotrf
C***********************************************************************
      SUBROUTINE psgetrf( M, N, A, IA, JA, DESCA, IPIV, INFO )
      IMPLICIT NONE
      INTEGER            IA, INFO, JA, M, N
      INTEGER            DESCA( * ), IPIV( * )
      REAL               A( * )
C        WRITE(*,*) 'Error. PSGETRF should not be called.'
        call rexit('Error. PSGETRF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psgetrf
C***********************************************************************
      SUBROUTINE pstrtrs( UPLO, TRANS, DIAG, N, NRHS, A, IA, JA, DESCA,
     &                    B, IB, JB, DESCB, INFO )
      IMPLICIT NONE
      CHARACTER          DIAG, TRANS, UPLO
      INTEGER            IA, IB, INFO, JA, JB, N, NRHS
      INTEGER            DESCA( * ), DESCB( * )
      REAL               A( * ), B( * )
C        WRITE(*,*) 'Error. PSTRTRS should not be called.'
        call rexit('Error. PSTRTRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pstrtrs
C***********************************************************************
      SUBROUTINE pdpotrf( UPLO, N, A, IA, JA, DESCA, INFO )
      IMPLICIT NONE
      CHARACTER          UPLO
      INTEGER            IA, INFO, JA, N
      INTEGER            DESCA( * )
      DOUBLE PRECISION   A( * )
C        WRITE(*,*) 'Error. PDPOTRF should not be called.'
        call rexit('Error. PDPOTRF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdpotrf
C***********************************************************************
      SUBROUTINE pdgetrf( M, N, A, IA, JA, DESCA, IPIV, INFO )
      IMPLICIT NONE
      INTEGER            IA, INFO, JA, M, N
      INTEGER            DESCA( * ), IPIV( * )
      DOUBLE PRECISION   A( * )
C        WRITE(*,*) 'Error. PDGETRF should not be called.'
        call rexit('Error. PDGETRF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdgetrf
C***********************************************************************
      SUBROUTINE pdtrtrs( UPLO, TRANS, DIAG, N, NRHS, A, IA, JA, DESCA,
     &                    B, IB, JB, DESCB, INFO )
      IMPLICIT NONE
      CHARACTER          DIAG, TRANS, UPLO
      INTEGER            IA, IB, INFO, JA, JB, N, NRHS
      INTEGER            DESCA( * ), DESCB( * )
      DOUBLE PRECISION   A( * ), B( * )
C        WRITE(*,*) 'Error. PDTRTRS should not be called.'
        call rexit('Error. PDTRTRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdtrtrs
C***********************************************************************
      SUBROUTINE INFOG2L( GRINDX, GCINDX, DESC, NPROW, NPCOL, MYROW,
     &                    MYCOL, LRINDX, LCINDX, RSRC, CSRC )
      IMPLICIT NONE
      INTEGER            CSRC, GCINDX, GRINDX, LRINDX, LCINDX, MYCOL,
     &                   MYROW, NPCOL, NPROW, RSRC
      INTEGER            DESC( * )
C        WRITE(*,*) 'Error. INFOG2L should not be called.'
        call rexit('Error. INFOG2L should not be called.')
C        STOP
      RETURN
      END SUBROUTINE INFOG2L
C***********************************************************************
      INTEGER FUNCTION INDXG2P( INDXGLOB, NB, IPROC, ISRCPROC, NPROCS )
      INTEGER            INDXGLOB, IPROC, ISRCPROC, NB, NPROCS
        INDXG2P = 0
C        WRITE(*,*) 'Error. INFOG2L should not be called.'
        call rexit('Error. INFOG2L should not be called.')
C        STOP
      RETURN
      END FUNCTION INDXG2P
C***********************************************************************
      SUBROUTINE pcscal(N, ALPHA, X, IX, JX, DESCX, INCX)
      IMPLICIT NONE
      INTEGER            INCX, N, IX, JX
      COMPLEX            ALPHA
      COMPLEX            X( * )
      INTEGER            DESCX( * )
C        WRITE(*,*) 'Error. PCSCAL should not be called.'
        call rexit('Error. PCSCAL should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcscal
C***********************************************************************
      SUBROUTINE pzscal(N, ALPHA, X, IX, JX, DESCX, INCX)
      IMPLICIT NONE
      INTEGER            INCX, N, IX, JX
C     DOUBLE COMPLEX     ALPHA
C     DOUBLE COMPLEX     X( * )
      COMPLEX(kind=kind(0.0D0)) :: ALPHA, X( * )
      INTEGER            DESCX( * )
C        WRITE(*,*) 'Error. PZSCAL should not be called.'
        call rexit('Error. PZSCAL should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzscal
C***********************************************************************
      SUBROUTINE pdscal(N, ALPHA, X, IX, JX, DESCX, INCX)
      IMPLICIT NONE
      INTEGER            INCX, N, IX, JX
      DOUBLE PRECISION   ALPHA
      DOUBLE PRECISION   X( * )
      INTEGER            DESCX( * )
C        WRITE(*,*) 'Error. PDSCAL should not be called.'
        call rexit('Error. PDSCAL should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdscal
C***********************************************************************
      SUBROUTINE psscal(N, ALPHA, X, IX, JX, DESCX, INCX)
      IMPLICIT NONE
      INTEGER            INCX, N, IX, JX
      REAL               ALPHA
      REAL               X( * )
      INTEGER            DESCX( * )
C        WRITE(*,*) 'Error. PSSCAL should not be called.'
        call rexit('Error. PSSCAL should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psscal
C***********************************************************************
      SUBROUTINE pzdot
     &    ( N, DOT, X, IX, JX, DESCX, INCX, Y, IY, JY, DESCY, INCY )
      IMPLICIT NONE
      INTEGER N, IX, JX, IY, JY, INCX, INCY
      INTEGER DESCX(*), DESCY(*)
C     DOUBLE COMPLEX X(*), Y(*)
      COMPLEX(kind=kind(0.0D0)) :: X(*), Y(*)
      DOUBLE PRECISION DOT
        DOT = 0.0d0
C        WRITE(*,*) 'Error. PZDOT should not be called.'
        call rexit('Error. PZDOT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzdot
C***********************************************************************
      SUBROUTINE pcdot
     &    ( N, DOT, X, IX, JX, DESCX, INCX, Y, IY, JY, DESCY, INCY )
      IMPLICIT NONE
      INTEGER N, IX, JX, IY, JY, INCX, INCY
      INTEGER DESCX(*), DESCY(*)
      COMPLEX X(*), Y(*)
      REAL DOT
        DOT = 0.0e0
C        WRITE(*,*) 'Error. PCDOT should not be called.'
        call rexit('Error. PCDOT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcdot
C***********************************************************************
      SUBROUTINE pddot
     &    ( N, DOT, X, IX, JX, DESCX, INCX, Y, IY, JY, DESCY, INCY )
      IMPLICIT NONE
      INTEGER N, IX, JX, IY, JY, INCX, INCY
      INTEGER DESCX(*), DESCY(*)
      DOUBLE PRECISION X(*), Y(*), DOT
        DOT = 0.0d0
C        WRITE(*,*) 'Error. PDDOT should not be called.'
        call rexit('Error. PDDOT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pddot
C***********************************************************************
      SUBROUTINE psdot
     &    ( N, DOT, X, IX, JX, DESCX, INCX, Y, IY, JY, DESCY, INCY )
      IMPLICIT NONE
      INTEGER N, IX, JX, IY, JY, INCX, INCY
      INTEGER DESCX(*), DESCY(*)
      REAL X(*), Y(*), DOT
        DOT = 0.0e0
C        WRITE(*,*) 'Error. PSDOT should not be called.'
        call rexit('Error. PSDOT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psdot
C***********************************************************************
      SUBROUTINE zgebs2d( CONTXT, SCOPE, TOP, M, N, A, LDA )
      IMPLICIT NONE
      INTEGER CONTXT, M, N, LDA
C     DOUBLE COMPLEX A(*)
      COMPLEX(kind=kind(0.0D0)) :: A(*)
      CHARACTER SCOPE, TOP
C        WRITE(*,*) 'Error. ZGEBS2D should not be called.'
        call rexit('Error. ZGEBS2D should not be called.')
C        STOP
      RETURN
      END SUBROUTINE zgebs2d
C***********************************************************************
      SUBROUTINE cgebs2d( CONTXT, SCOPE, TOP, M, N, A, LDA )
      IMPLICIT NONE
      INTEGER CONTXT, M, N, LDA
      COMPLEX A(*)
      CHARACTER SCOPE, TOP
C        WRITE(*,*) 'Error. CGEBS2D should not be called.'
        call rexit('Error. CGEBS2D should not be called.')
C        STOP
      RETURN
      END SUBROUTINE cgebs2d
C***********************************************************************
      SUBROUTINE sgebs2d( CONTXT, SCOPE, TOP, M, N, A, LDA )
      IMPLICIT NONE
      INTEGER CONTXT, M, N, LDA
      REAL A(*)
      CHARACTER SCOPE, TOP
C        WRITE(*,*) 'Error. SGEBS2D should not be called.'
        call rexit('Error. SGEBS2D should not be called.')
C        STOP
      RETURN
      END SUBROUTINE sgebs2d
C***********************************************************************
      SUBROUTINE dgebs2d( CONTXT, SCOPE, TOP, M, N, A, LDA )
      IMPLICIT NONE
      INTEGER CONTXT, M, N, LDA
      DOUBLE PRECISION A(*)
      CHARACTER SCOPE, TOP
C        WRITE(*,*) 'Error. DGEBS2D should not be called.'
        call rexit('Error. DGEBS2D should not be called.')
C        STOP
      RETURN
      END SUBROUTINE dgebs2d
C***********************************************************************
      SUBROUTINE zgebr2d( CONTXT, SCOPE, TOP, M, N, A, LDA )
      IMPLICIT NONE
      INTEGER CONTXT, M, N, LDA
C     DOUBLE COMPLEX A(*)
      COMPLEX(kind=kind(0.0D0)) :: A(*)
      CHARACTER SCOPE, TOP
C        WRITE(*,*) 'Error. ZGEBR2D should not be called.'
        call rexit('Error. ZGEBR2D should not be called.')
C        STOP
      RETURN
      END SUBROUTINE zgebr2d
C***********************************************************************
      SUBROUTINE cgebr2d( CONTXT, SCOPE, TOP, M, N, A, LDA )
      IMPLICIT NONE
      INTEGER CONTXT, M, N, LDA
      COMPLEX A(*)
      CHARACTER SCOPE, TOP
C        WRITE(*,*) 'Error. CGEBR2D should not be called.'
        call rexit('Error. CGEBR2D should not be called.')
C        STOP
      RETURN
      END SUBROUTINE cgebr2d
C***********************************************************************
      SUBROUTINE sgebr2d( CONTXT, SCOPE, TOP, M, N, A, LDA )
      IMPLICIT NONE
      INTEGER CONTXT, M, N, LDA
      REAL A(*)
      CHARACTER SCOPE, TOP
C        WRITE(*,*) 'Error. SGEBR2D should not be called.'
        call rexit('Error. SGEBR2D should not be called.')
C        STOP
      RETURN
      END SUBROUTINE sgebr2d
C***********************************************************************
      SUBROUTINE dgebr2d( CONTXT, SCOPE, TOP, M, N, A, LDA )
      IMPLICIT NONE
      INTEGER CONTXT, M, N, LDA
      DOUBLE PRECISION A(*)
      CHARACTER SCOPE, TOP
C        WRITE(*,*) 'Error. DGEBR2D should not be called.'
        call rexit('Error. DGEBR2D should not be called.')
C        STOP
      RETURN
      END SUBROUTINE dgebr2d
C***********************************************************************
      SUBROUTINE pcgetrs( TRANS, N, NRHS, A, IA, JA, DESCA, IPIV, B,
     &                    IB, JB, DESCB, INFO )
      IMPLICIT NONE
      CHARACTER          TRANS
      INTEGER            IA, IB, INFO, JA, JB, N, NRHS
      INTEGER            DESCA( * ), DESCB( * ), IPIV( * )
      COMPLEX            A( * ), B( * )
C        WRITE(*,*) 'Error. PCGETRS should not be called.'
        call rexit('Error. PCGETRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcgetrs
C***********************************************************************
      SUBROUTINE pzgetrs( TRANS, N, NRHS, A, IA, JA, DESCA, IPIV, B,
     &                    IB, JB, DESCB, INFO )
      IMPLICIT NONE
      CHARACTER          TRANS
      INTEGER            IA, IB, INFO, JA, JB, N, NRHS
      INTEGER            DESCA( * ), DESCB( * ), IPIV( * )
c     DOUBLE COMPLEX     A( * ), B( * )
      COMPLEX(kind=kind(0.0D0)) ::     A( * ), B( * )
C        WRITE(*,*) 'Error. PZGETRS should not be called.'
        call rexit('Error. PZGETRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzgetrs
C***********************************************************************
      SUBROUTINE psgetrs( TRANS, N, NRHS, A, IA, JA, DESCA, IPIV, B,
     &                    IB, JB, DESCB, INFO )
      IMPLICIT NONE
      CHARACTER          TRANS
      INTEGER            IA, IB, INFO, JA, JB, N, NRHS
      INTEGER            DESCA( * ), DESCB( * ), IPIV( * )
      REAL               A( * ), B( * )
C        WRITE(*,*) 'Error. PSGETRS should not be called.'
        call rexit('Error. PSGETRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psgetrs
C***********************************************************************
      SUBROUTINE pdgetrs( TRANS, N, NRHS, A, IA, JA, DESCA, IPIV, B,
     &                    IB, JB, DESCB, INFO )
      IMPLICIT NONE
      CHARACTER          TRANS
      INTEGER            IA, IB, INFO, JA, JB, N, NRHS
      INTEGER            DESCA( * ), DESCB( * ), IPIV( * )
      DOUBLE PRECISION   A( * ), B( * )
C        WRITE(*,*) 'Error. PDGETRS should not be called.'
        call rexit('Error. PDGETRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdgetrs
C***********************************************************************
      SUBROUTINE pcpotrs( UPLO, N, NRHS, A, IA, JA, DESCA, B, IB, JB,
     &           DESCB, INFO )
      IMPLICIT NONE
      CHARACTER       UPLO
      INTEGER         IA, IB, INFO, JA, JB, N, NRHS
      INTEGER         DESCA( * ), DESCB( * )
      COMPLEX         A( * ), B( * )
C        WRITE(*,*) 'Error. PCPOTRS should not be called.'
        call rexit('Error. PCPOTRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcpotrs
C***********************************************************************
      SUBROUTINE pzpotrs( UPLO, N, NRHS, A, IA, JA, DESCA, B, IB, JB,
     &           DESCB, INFO )
      IMPLICIT NONE
      CHARACTER       UPLO
      INTEGER         IA, IB, INFO, JA, JB, N, NRHS
      INTEGER         DESCA( * ), DESCB( * )
c     DOUBLE COMPLEX     A( * ), B( * )
      COMPLEX(kind=kind(0.0D0)) ::     A( * ), B( * )
C        WRITE(*,*) 'Error. PZPOTRS should not be called.'
        call rexit('Error. PZPOTRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzpotrs
C***********************************************************************
      SUBROUTINE pspotrs( UPLO, N, NRHS, A, IA, JA, DESCA, B, IB, JB,
     &           DESCB, INFO )
      IMPLICIT NONE
      CHARACTER       UPLO
      INTEGER         IA, IB, INFO, JA, JB, N, NRHS
      INTEGER         DESCA( * ), DESCB( * )
      REAL            A( * ), B( * )
C        WRITE(*,*) 'Error. PSPOTRS should not be called.'
        call rexit('Error. PSPOTRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pspotrs
C***********************************************************************
      SUBROUTINE pdpotrs( UPLO, N, NRHS, A, IA, JA, DESCA, B, IB, JB,
     &           DESCB, INFO )
      IMPLICIT NONE
      CHARACTER       UPLO
      INTEGER         IA, IB, INFO, JA, JB, N, NRHS
      INTEGER         DESCA( * ), DESCB( * )
      DOUBLE          PRECISION A( * ), B( * )
C        WRITE(*,*) 'Error. PDPOTRS should not be called.'
        call rexit('Error. PDPOTRS should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdpotrs
C***********************************************************************
      SUBROUTINE pscnrm2( N, NORM2, X, IX, JX, DESCX, INCX )
      IMPLICIT NONE
      INTEGER N, IX, JX, INCX
      INTEGER DESCX(*)
      REAL NORM2
      COMPLEX X( * )
C        WRITE(*,*) 'Error. PCNRM2 should not be called.'
        call rexit('Error. PCNRM2 should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pscnrm2
C***********************************************************************
      SUBROUTINE pdznrm2( N, NORM2, X, IX, JX, DESCX, INCX )
      IMPLICIT NONE
      INTEGER N, IX, JX, INCX
      INTEGER DESCX(*)
      DOUBLE PRECISION NORM2
C     DOUBLE COMPLEX X( * )
      COMPLEX(kind=kind(0.0D0)) :: X( * )
C        WRITE(*,*) 'Error. PZNRM2 should not be called.'
        call rexit('Error. PZNRM2 should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdznrm2
C***********************************************************************
      SUBROUTINE psnrm2( N, NORM2, X, IX, JX, DESCX, INCX )
      IMPLICIT NONE
      INTEGER N, IX, JX, INCX
      INTEGER DESCX(*)
      REAL    NORM2, X( * )
C        WRITE(*,*) 'Error. PSNRM2 should not be called.'
        call rexit('Error. PSNRM2 should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psnrm2
C***********************************************************************
      SUBROUTINE pdnrm2( N, NORM2, X, IX, JX, DESCX, INCX )
      IMPLICIT NONE
      INTEGER N, IX, JX, INCX
      INTEGER DESCX(*)
      DOUBLE PRECISION NORM2, X( * )
C        WRITE(*,*) 'Error. PDNRM2 should not be called.'
        call rexit('Error. PDNRM2 should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdnrm2
C***********************************************************************
      REAL FUNCTION pclange( NORM, M, N, A, IA,  JA,
     &                 DESCA, WORK )
      CHARACTER    NORM
      INTEGER      IA, JA, M, N
      INTEGER      DESCA( * )
      COMPLEX      A( * ), WORK( * )
      PCLANGE = 0.0e0
C        WRITE(*,*) 'Error. PCLANGE should not be called.'
        call rexit('Error. PCLANGE should not be called.')
C        STOP
      RETURN
      END FUNCTION pclange
C***********************************************************************
      DOUBLE PRECISION FUNCTION pzlange( NORM, M, N, A, IA,  JA,
     &                 DESCA, WORK )
      CHARACTER    NORM
      INTEGER      IA, JA, M, N
      INTEGER      DESCA( * )
      REAL         A( * ), WORK( * )
      PZLANGE = 0.0d0
C        WRITE(*,*) 'Error. PZLANGE should not be called.'
        call rexit('Error. PZLANGE should not be called.')
C        STOP
      RETURN
      END FUNCTION pzlange
C***********************************************************************
      REAL FUNCTION pslange( NORM, M, N, A, IA,  JA,
     &                 DESCA, WORK )
      CHARACTER    NORM
      INTEGER      IA, JA, M, N
      INTEGER      DESCA( * )
      REAL         A( * ), WORK( * )
      PSLANGE = 0.0e0
C        WRITE(*,*) 'Error. PSLANGE should not be called.'
        call rexit('Error. PSLANGE should not be called.')
C        STOP
      RETURN
      END FUNCTION pslange
C***********************************************************************
      DOUBLE PRECISION FUNCTION pdlange( NORM, M, N, A, IA,  JA,
     &                 DESCA, WORK )
      CHARACTER    NORM
      INTEGER      IA, JA, M, N
      INTEGER      DESCA( * )
      DOUBLE       PRECISION A( * ), WORK( * )
      PDLANGE = 0.0d0
C        WRITE(*,*) 'Error. PDLANGE should not be called.'
        call rexit('Error. PDLANGE should not be called.')
C        STOP
      RETURN
      END FUNCTION pdlange
C***********************************************************************
      SUBROUTINE pcgecon( NORM, N,  A,  IA,  JA,  DESCA,  ANORM,
     &           RCOND,  WORK,  LWORK,  IWORK,  LIWORK, INFO )
      IMPLICIT NONE

      CHARACTER       NORM
      INTEGER         IA, INFO, JA, LIWORK, LWORK, N
      REAL            ANORM, RCOND
      INTEGER         DESCA( * ), IWORK( * )
      COMPLEX         A( * ), WORK( * )
C        WRITE(*,*) 'Error. PCGECON should not be called.'
        call rexit('Error. PCGECON should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcgecon
C***********************************************************************
      SUBROUTINE pzgecon( NORM, N,  A,  IA,  JA,  DESCA,  ANORM,
     &           RCOND,  WORK,  LWORK,  IWORK,  LIWORK, INFO )
      IMPLICIT NONE

      CHARACTER       NORM
      INTEGER         IA, INFO, JA, LIWORK, LWORK, N
      DOUBLE PRECISION ANORM, RCOND
      INTEGER         DESCA( * ), IWORK( * )
C     DOUBLE COMPLEX  A( * ), WORK( * )
      COMPLEX(kind=kind(0.0D0)) :: A( * ), WORK( * )
C        WRITE(*,*) 'Error. PZGECON should not be called.'
        call rexit('Error. PZGECON should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzgecon
C***********************************************************************
      SUBROUTINE psgecon( NORM, N,  A,  IA,  JA,  DESCA,  ANORM,
     &           RCOND,  WORK,  LWORK,  IWORK,  LIWORK, INFO )
      IMPLICIT NONE

      CHARACTER       NORM
      INTEGER         IA, INFO, JA, LIWORK, LWORK, N
      REAL            ANORM, RCOND
      INTEGER         DESCA( * ), IWORK( * )
      REAL            A( * ), WORK( * )
C        WRITE(*,*) 'Error. PSGECON should not be called.'
        call rexit('Error. PSGECON should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psgecon
C***********************************************************************
      SUBROUTINE pdgecon( NORM, N,  A,  IA,  JA,  DESCA,  ANORM,
     &           RCOND,  WORK,  LWORK,  IWORK,  LIWORK, INFO )
      IMPLICIT NONE

      CHARACTER       NORM
      INTEGER         IA, INFO, JA, LIWORK, LWORK, N
      DOUBLE          PRECISION ANORM, RCOND
      INTEGER         DESCA( * ), IWORK( * )
      DOUBLE          PRECISION A( * ), WORK( * )
C        WRITE(*,*) 'Error. PDGECON should not be called.'
        call rexit('Error. PDGECON should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdgecon
C***********************************************************************
      SUBROUTINE pcgeqpf( M,  N,  A,  IA,  JA, DESCA, IPIV, TAU,
     &           WORK, LWORK, INFO )
      IMPLICIT NONE
      INTEGER    IA, JA, INFO, LWORK, M, N
      INTEGER    DESCA( * ), IPIV( * )
      COMPLEX    A( * ), TAU( * ), WORK( * )
C        WRITE(*,*) 'Error. PCGEQPF should not be called.'
        call rexit('Error. PCGEQPF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcgeqpf
C***********************************************************************
      SUBROUTINE pzgeqpf( M,  N,  A,  IA,  JA, DESCA, IPIV, TAU,
     &           WORK, LWORK, INFO )
      IMPLICIT NONE
      INTEGER    IA, JA, INFO, LWORK, M, N
      INTEGER    DESCA( * ), IPIV( * )
C     DOUBLE COMPLEX A( * ), TAU( * ), WORK( * )
      COMPLEX(kind=kind(0.0D0)) :: A( * ), TAU( * ), WORK( * )
C        WRITE(*,*) 'Error. PZGEQPF should not be called.'
        call rexit('Error. PZGEQPF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzgeqpf
C***********************************************************************
      SUBROUTINE psgeqpf( M,  N,  A,  IA,  JA, DESCA, IPIV, TAU,
     &           WORK, LWORK, INFO )
      IMPLICIT NONE
      INTEGER         IA, JA, INFO, LWORK, M, N
      INTEGER         DESCA( * ), IPIV( * )
      REAL       A( * ), TAU( * ), WORK( * )
C        WRITE(*,*) 'Error. PSGEQPF should not be called.'
        call rexit('Error. PSGEQPF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psgeqpf
C***********************************************************************
      SUBROUTINE pdgeqpf( M,  N,  A,  IA,  JA, DESCA, IPIV, TAU,
     &           WORK, LWORK, INFO )
      IMPLICIT NONE
      INTEGER         IA, JA, INFO, LWORK, M, N
      INTEGER         DESCA( * ), IPIV( * )
      DOUBLE PRECISION A( * ), TAU( * ), WORK( * )
C        WRITE(*,*) 'Error. PDGEQPF should not be called.'
        call rexit('Error. PDGEQPF should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdgeqpf
C***********************************************************************
      SUBROUTINE pcaxpy(N, A, X, IX, JX, DESCX, INCX, Y, IY, JY,
     &           DESCY, INCY)
      IMPLICIT NONE
      INTEGER N, IX, IY, JX, JY, INCX, INCY
      INTEGER DESCX(*), DESCY(*)
      COMPLEX A(*),X(*),Y(*)
C        WRITE(*,*) 'Error. PCAXPY should not be called.'
        call rexit('Error. PCAXPY should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcaxpy
C***********************************************************************
      SUBROUTINE pzaxpy(N, A, X, IX, JX, DESCX, INCX, Y, IY, JY,
     &           DESCY, INCY)
      IMPLICIT NONE
      INTEGER N, IX, IY, JX, JY, INCX, INCY
      INTEGER DESCX(*), DESCY(*)
C     DOUBLE COMPLEX A(*),X(*),Y(*)
      COMPLEX(kind=kind(0.0D0)) :: A(*),X(*),Y(*)
C        WRITE(*,*) 'Error. PZAXPY should not be called.'
        call rexit('Error. PZAXPY should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzaxpy
C***********************************************************************
      SUBROUTINE psaxpy(N, A, X, IX, JX, DESCX, INCX, Y, IY, JY,
     &           DESCY, INCY)
      IMPLICIT NONE
      INTEGER N, IX, IY, JX, JY, INCX, INCY
      INTEGER DESCX(*), DESCY(*)
      REAL A(*),X(*),Y(*)
C        WRITE(*,*) 'Error. PSAXPY should not be called.'
        call rexit('Error. PSAXPY should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psaxpy
C***********************************************************************
      SUBROUTINE pdaxpy(N, A, X, IX, JX, DESCX, INCX, Y, IY, JY,
     &           DESCY, INCY)
      IMPLICIT NONE
      INTEGER N, IX, IY, JX, JY, INCX, INCY
      INTEGER DESCX(*), DESCY(*)
      DOUBLE PRECISION A(*),X(*),Y(*)
C        WRITE(*,*) 'Error. PDAXPY should not be called.'
        call rexit('Error. PDAXPY should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdaxpy
C***********************************************************************
      SUBROUTINE pctrsm ( SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, IA,
     $                   JA, DESCA, B, IB, JB, DESCB )
      IMPLICIT NONE
      CHARACTER          SIDE, UPLO, TRANSA, DIAG
      INTEGER            M, N, IA, JA, IB, JB
      COMPLEX            ALPHA
      INTEGER            DESCA( * ), DESCB( * )
      COMPLEX            A( * ), B( * )
C        WRITE(*,*) 'Error. PCTRSM should not be called.'
        call rexit('Error. PCTRSM should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pctrsm 
C***********************************************************************
      SUBROUTINE pztrsm ( SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, IA,
     $                   JA, DESCA, B, IB, JB, DESCB )
      IMPLICIT NONE
      CHARACTER          SIDE, UPLO, TRANSA, DIAG
      INTEGER            M, N, IA, JA, IB, JB
C     DOUBLE COMPLEX     ALPHA
      COMPLEX(kind=kind(0.0D0)) ::     ALPHA
      INTEGER            DESCA( * ), DESCB( * )
C     DOUBLE COMPLEX     A( * ), B( * )
      COMPLEX(kind=kind(0.0D0)) ::     A( * ), B( * )
C        WRITE(*,*) 'Error. PZTRSM should not be called.'
        call rexit('Error. PZTRSM should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pztrsm 
C***********************************************************************
      SUBROUTINE pstrsm ( SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, IA,
     $                   JA, DESCA, B, IB, JB, DESCB )
      IMPLICIT NONE
      CHARACTER          SIDE, UPLO, TRANSA, DIAG
      INTEGER            M, N, IA, JA, IB, JB
      REAL               ALPHA
      INTEGER            DESCA( * ), DESCB( * )
      REAL               A( * ), B( * )
C        WRITE(*,*) 'Error. PSTRSM should not be called.'
        call rexit('Error. PSTRSM should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pstrsm 
C***********************************************************************
      SUBROUTINE pdtrsm ( SIDE, UPLO, TRANSA, DIAG, M, N, ALPHA, A, IA,
     $                   JA, DESCA, B, IB, JB, DESCB )
      IMPLICIT NONE
      CHARACTER          SIDE, UPLO, TRANSA, DIAG
      INTEGER            M, N, IA, JA, IB, JB
      DOUBLE PRECISION   ALPHA
      INTEGER            DESCA( * ), DESCB( * )
      DOUBLE PRECISION   A( * ), B( * )
C        WRITE(*,*) 'Error. PDTRSM should not be called.'
        call rexit('Error. PDTRSM should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdtrsm 
C***********************************************************************
      SUBROUTINE pcunmqr( SIDE,  TRANS,  M,  N,  K,  A,  IA, JA,
     &                    DESCA, TAU, C, IC,  JC,  DESCC,  WORK,
     &                    LWORK, INFO )
      IMPLICIT NONE
      CHARACTER SIDE, TRANS
      INTEGER   IA, IC, INFO, JA, JC, K, LWORK, M, N
      INTEGER   DESCA( * ), DESCC( * )
      COMPLEX   A(  *  ), C( * ), TAU( * ), WORK( * )
C        WRITE(*,*) 'Error. PCUNMQR should not be called.'
        call rexit('Error. PCUNMQR should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pcunmqr
C***********************************************************************
      SUBROUTINE pzunmqr( SIDE,  TRANS,  M,  N,  K,  A,  IA, JA,
     &                    DESCA, TAU, C, IC,  JC,  DESCC,  WORK,
     &                    LWORK, INFO )
      IMPLICIT NONE
      CHARACTER SIDE, TRANS
      INTEGER   IA, IC, INFO, JA, JC, K, LWORK, M, N
      INTEGER   DESCA( * ), DESCC( * )
C     DOUBLE COMPLEX A(  *  ), C( * ), TAU( * ), WORK( * )
      COMPLEX(kind=kind(0.0D0)) :: A(  *  ), C( * ), TAU( * ), WORK( * )
C        WRITE(*,*) 'Error. PZUNMQR should not be called.'
        call rexit('Error. PZUNMQR should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pzunmqr
C***********************************************************************
      SUBROUTINE psormqr( SIDE,  TRANS,  M,  N,  K,  A,  IA, JA,
     &                    DESCA, TAU, C, IC,  JC,  DESCC,  WORK,
     &                    LWORK, INFO )
      IMPLICIT NONE
      CHARACTER SIDE, TRANS
      INTEGER   IA, IC, INFO, JA, JC, K, LWORK, M, N
      INTEGER   DESCA( * ), DESCC( * )
      REAL      A(  *  ), C( * ), TAU( * ), WORK( * )
C        WRITE(*,*) 'Error. PSORMQR should not be called.'
        call rexit('Error. PSORMQR should not be called.')
C        STOP
      RETURN
      END SUBROUTINE psormqr
C***********************************************************************
      SUBROUTINE pdormqr( SIDE,  TRANS,  M,  N,  K,  A,  IA, JA,
     &                    DESCA, TAU, C, IC,  JC,  DESCC,  WORK,
     &                    LWORK, INFO )
      IMPLICIT NONE
      CHARACTER SIDE, TRANS
      INTEGER         IA, IC, INFO, JA, JC, K, LWORK, M, N
      INTEGER         DESCA( * ), DESCC( * )
      DOUBLE PRECISION  A(  *  ), C( * ), TAU( * ), WORK( * )
C        WRITE(*,*) 'Error. PDORMQR should not be called.'
        call rexit('Error. PDORMQR should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pdormqr
C***********************************************************************
      SUBROUTINE chk1mat( MA, MAPOS0, NA, NAPOS0, IA, JA, DESCA,
     &                    DESCAPOS0, INFO )
      IMPLICIT NONE
      INTEGER            DESCAPOS0, IA, INFO, JA, MA, MAPOS0, NA, NAPOS0
      INTEGER            DESCA( * )
C        WRITE(*,*) 'Error. CHK1MAT should not be called.'
        call rexit('Error. CHK1MAT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE chk1mat
C***********************************************************************
      SUBROUTINE pchk2mat( MA, MAPOS0, NA, NAPOS0, IA, JA, DESCA,
     &                     DESCAPOS0, MB, MBPOS0, NB, NBPOS0, IB, JB,
     &                     DESCB, DESCBPOS0, NEXTRA, EX, EXPOS, INFO )
      IMPLICIT NONE
      INTEGER            DESCAPOS0, DESCBPOS0, IA, IB, INFO, JA, JB, MA,
     &                   MAPOS0, MB, MBPOS0, NA, NAPOS0, NB, NBPOS0,
     &                   NEXTRA
      INTEGER            DESCA( * ), DESCB( * ), EX( NEXTRA ),
     &                   EXPOS( NEXTRA )
C        WRITE(*,*) 'Error. PCHK2MAT should not be called.'
        call rexit('Error. PCHK2MAT should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pchk2mat
C***********************************************************************
      SUBROUTINE pxerbla( CONTXT, SRNAME, INFO )
      IMPLICIT NONE
      INTEGER CONTXT, INFO
      CHARACTER SRNAME
C        WRITE(*,*) 'Error. PXERBLA should not be called.'
        call rexit('Error. PXERBLA should not be called.')
C        STOP
      RETURN
      END SUBROUTINE pxerbla
C***********************************************************************
      SUBROUTINE descset( DESC, M, N, MB, NB, IRSRC, ICSRC, ICTXT,
     &                    LLD )
      IMPLICIT NONE
      INTEGER            ICSRC, ICTXT, IRSRC, LLD, M, MB, N, NB
      INTEGER            DESC( * )
C        WRITE(*,*) 'Error. DESCSET should not be called.'
        call rexit('Error. DESCSET should not be called.')
C        STOP
      RETURN
      END SUBROUTINE descset

