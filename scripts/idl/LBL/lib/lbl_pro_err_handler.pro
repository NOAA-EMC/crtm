  ; Procedure message handler
  @error_codes
  IF ( KEYWORD_SET(Debug) ) THEN BEGIN
    MESSAGE, '--> Entered.', /INFORMATIONAL
    MsgSwitch = 0
  ENDIF ELSE BEGIN
    CATCH, Error_Status
    IF ( Error_Status NE 0 ) THEN BEGIN
      CATCH, /CANCEL
      IF ( N_ELEMENTS(FileId) GT 0 ) THEN FREE_LUN, FileId
      MESSAGE, !ERROR_STATE.MSG
    ENDIF
    MsgSwitch = 1
  ENDELSE

