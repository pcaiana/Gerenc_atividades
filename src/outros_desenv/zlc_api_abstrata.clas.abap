class ZLC_API_ABSTRATA definition
  public
  abstract
  create public .

public section.

  methods VALIDATE_TOKE
    importing
      !IV_TOKEN type STRING
    returning
      value(EV_IS_VALID) type XFELD .
protected section.
private section.
ENDCLASS.



CLASS ZLC_API_ABSTRATA IMPLEMENTATION.


  METHOD validate_toke.
    IF iv_token IS INITIAL.
      ev_is_valid = abap_false.
    ELSE.
      ev_is_valid = abap_true.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
