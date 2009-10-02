;+
; NAME:
;       LBL_Solar::Init
;
; PURPOSE:
;       The LBL_Solar::Init function method initialises an LBL_Solar object.
;
;       NOTE: Init methods are special *lifecycle methods* and, as
;             such, cannot be called outside the context of object
;             creation. This means that in most cases you cannot call
;             the Init method directly. There is one exception to this
;             rule: if you write your own subclass of this class, you
;             can call the Init method from within the Init method of
;             the subclass.
;
; CALLING SEQUENCE:
;       Obj = OBJ_NEW( 'LBL_Solar', Debug=Debug )
;
;         or, in a lifecycle method,
;
;       Result = Obj->[LBL_Solar::]Init( Debug=Debug )
;
; KEYWORDS:
;       Along with any of the group of keywords accepted by the
;       LBL_Solar::Set_Property procedure method, the following
;       keywords are also accepted:
;
;       Debug:       Set this keyword for debugging.
;                    If NOT SET => Error handler is enabled. (DEFAULT)
;                       SET     => Error handler is disabled; Routine
;                                  traceback output is enabled.
;                    UNITS:      N/A
;                    TYPE:       INTEGER
;                    DIMENSION:  Scalar
;                    ATTRIBUTES: INTENT(IN), OPTIONAL
;
; FUNCTION RESULT:
;       Result:      The return value is an integer defining the object
;                    initialisation status. The return codes are defined
;                    in the error_codes include file.
;                    If == TRUE the object creation was sucessful
;                       == FALSE an unrecoverable error occurred
;                    
;                    UNITS:      N/A
;                    TYPE:       INTEGER
;                    DIMENSION:  Scalar
;
; EXAMPLE:
;       The Init method is invoked when an LBL_Solar object is created,
;
;         IDL> x = OBJ_NEW('LBL_Solar')
;
; CREATION HISTORY:
;       Written by:     Paul van Delst, 17-Jul-2009
;                       paul.vandelst@noaa.gov
;
;-

FUNCTION LBL_Solar::Init, $
  Debug  = Debug, $
  _EXTRA = Properties  ; Keywords passed onto LBL_Solar::Set_Property

  ; Set up
  COMPILE_OPT HIDDEN
  @lbl_solar_parameters
  @error_codes
  IF ( KEYWORD_SET(Debug) ) THEN BEGIN
    MESSAGE, '--> Entered.', /INFORMATIONAL
    MsgSwitch = 0
  ENDIF ELSE BEGIN
    CATCH, Error_Status
    IF ( Error_Status NE 0 ) THEN BEGIN
      CATCH, /CANCEL
      MESSAGE, !ERROR_STATE.MSG, /CONTINUE
      RETURN, FALSE
    ENDIF
    MsgSwitch = 1
  ENDELSE
 

  ; Set default values for public members
  self.inflag  = 0L
  self.iotflag = 0L
  self.juldat  = 0L


  ; Set supplied properties.
  self->Set_Property, _EXTRA = Properties, Debug = Debug
  

  ; Done  
  CATCH, /CANCEL
  RETURN, TRUE
 
END ; FUNCTION LBL_Solar::Init
