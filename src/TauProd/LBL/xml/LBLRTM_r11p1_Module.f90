!
! LBLRTM_r11p1_Module
!
! Module containing procedures for LBLRTM Record r11p1.
!
!
! CREATION HISTORY:
!       Written by:   Paul van Delst, 24-Dec-2012
!                     paul.vandelst@noaa.gov
!

MODULE LBLRTM_r11p1_Module

  ! -----------------
  ! Environment setup
  ! -----------------
  ! Module usage
  USE Type_Kinds     , ONLY: fp
  USE File_Utility   , ONLY: File_Open
  USE Message_Handler, ONLY: SUCCESS, FAILURE, INFORMATION, Display_Message
  ! Line-by-line model parameters
  USE LBL_Parameters
  ! Disable implicit typing
  IMPLICIT NONE


  ! ----------
  ! Visibility
  ! ----------
  ! Everything private by default
  PRIVATE
  ! Datatypes
  PUBLIC :: LBLRTM_r11p1_type
  ! Procedures
  PUBLIC :: LBLRTM_r11p1_Write


  ! -----------------
  ! Module parameters
  ! -----------------
  CHARACTER(*), PARAMETER :: MODULE_VERSION_ID = &
  ! Message string length
  INTEGER, PARAMETER :: ML = 256
  ! The record I/O format
  CHARACTER(*), PARAMETER :: LBLRTM_R11P1_FMT = '(f10.3,f10.4,6i5,a35)'


  ! -------------
  ! Derived types
  ! -------------
  TYPE :: LBLRTM_r11p1_type
    REAL(fp)      :: v1f    = 0.0_fp  !  Wavenumber iof initial SRF/filter value
    REAL(fp)      :: dvf    = 0.0_fp  !  Wavenumber increment between SRF/filter values
    INTEGER       :: npts   = 0       !  Number of SRF/filter values
    INTEGER       :: jemit  = 0       !  Data selection flag. -1==absorption; 0==transmittance; 1==radiance
    INTEGER       :: iunit  = 0       !  Unit designation of file to be integrated
    INTEGER       :: ifilst = 0       !  Initial file from IUNIT to be integrated
    INTEGER       :: nifils = 0       !  Number of files to be integrated starting at IFILST
    INTEGER       :: junit  = 0       !  Unit designation for output file containing integrated results (named 'FLT_OUT')
    CHARACTER(35) :: heddr  = ''      !  User identification
  END TYPE LBLRTM_r11p1_type


CONTAINS


  FUNCTION LBLRTM_r11p1_Write(r11p1,fid) RESULT(err_stat)

    ! Arguments
    TYPE(LBLRTM_r11p1_type), INTENT(IN) :: r11p1
    INTEGER                , INTENT(IN) :: fid
    ! Function result
    INTEGER :: err_stat
    ! Function parameters
    CHARACTER(*), PARAMETER :: ROUTINE_NAME = 'LBLRTM_r11p1_Write'
    ! Function variables
    CHARACTER(ML) :: msg
    CHARACTER(ML) :: io_msg
    INTEGER :: io_stat

    ! Setup
    err_stat = SUCCESS
    ! ...Check unit is open
    IF ( .NOT. File_Open(fid) ) THEN
      msg = 'File unit is not connected'
      CALL Cleanup(); RETURN
    END IF

    ! Write the record
    WRITE( fid,FMT=LBLRTM_R11P1_FMT,IOSTAT=io_stat,IOMSG=io_msg) r11p1
    IF ( io_stat /= 0 ) THEN
      msg = 'Error writing record - '//TRIM(io_msg)
      CALL Cleanup(); RETURN
    END IF

  CONTAINS

    SUBROUTINE CleanUp()
      err_stat = FAILURE
      CALL Display_Message( ROUTINE_NAME,msg,err_stat )
    END SUBROUTINE CleanUp

  END FUNCTION LBLRTM_r11p1_Write

END MODULE LBLRTM_r11p1_Module
