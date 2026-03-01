*----------------------------------------------------------------------*
***INCLUDE LZDLPCT_002F01.
*----------------------------------------------------------------------*
FORM CREATE_REGISTER.

  GET TIME STAMP FIELD DATA(lv_criado_em).
  zdlpct_002-criado_por = sy-uname.
  zdlpct_002-criado_em  = lv_criado_em.

ENDFORM.

FORM MODIFY_REGISTER.

ENDFORM.
