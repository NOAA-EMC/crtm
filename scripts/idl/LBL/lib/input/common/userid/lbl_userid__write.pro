;+
; NAME:
;       LBL_UserId::Write
;
; PURPOSE:
;       The LBL_UserId::Write procedure method writes the
;       LBL_UserId object to a file
;
; CALLING SEQUENCE:
;       Obj->[LBL_UserId::]Write, $
;         FileId       , $ ;  Input
;         Debug = Debug    ;  Input keyword
;
; INPUT:
;       FileId:      The file id to which to write. Must be an id for
;                    a valid, open file.
;                    UNITS:      N/A
;                    TYPE:       INTEGER
;                    DIMENSION:  Scalar
;                    ATTRIBUTES: INTENT(IN)
;
; KEYWORDS:
;       Debug:       Set this keyword for debugging.
;                    If NOT SET => Error handler is enabled. (DEFAULT)
;                       SET     => Error handler is disabled; Routine
;                                  traceback output is enabled.
;                    UNITS:      N/A
;                    TYPE:       INTEGER
;                    DIMENSION:  Scalar
;                    ATTRIBUTES: INTENT(IN), OPTIONAL
;
; INCLUDE FILES:
;       lbl_parameters: Include file containing lbl specific
;                       parameter value definitions.
;
;       lbl_pro_err_handler: Error handler code for lbl procedures.
;
;
; CREATION HISTORY:
;       Written by:     Paul van Delst, 16-Jul-2009
;                       paul.vandelst@noaa.gov
;
;-


PRO LBL_UserId::Write, $
  FileId       , $ ; Input
  Debug = Debug    ; Input keyword

  ; Set up
  COMPILE_OPT HIDDEN
  @lbl_userid_parameters
  @lbl_pro_err_handler
  ; ...Check input
  IF ( N_ELEMENTS(FileId) EQ 0 ) THEN $
      MESSAGE, 'Must specify a valid FileId', $
        NONAME=MsgSwitch, NOPRINT=MsgSwitch
  info = FSTAT(FileId)
  IF (info.OPEN EQ 0 ) THEN $
    MESSAGE, 'FileID does not refer to an open file', $
      NONAME=MsgSwitch, NOPRINT=MsgSwitch
  

  ; Get the data
  self->Get_Property, $
    Debug          = Debug    , $
    Identification = Identification, $
    lbl_fmt        = lbl_fmt   
    
    
  ; Output record
  PRINTF, FileId, FORMAT=lbl_fmt, $
    STRTRIM(Identification,2)
  

  ; Done
  CATCH, /CANCEL

END ; PRO LBL_UserId::Write
