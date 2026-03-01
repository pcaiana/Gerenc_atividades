*----------------------------------------------------------------------*
***INCLUDE LZDLPCT_003F01.
*----------------------------------------------------------------------*
FORM CREATE_REGISTER.

  GET TIME STAMP FIELD DATA(lv_criado_em).
  zdlpct_003-criado_por = sy-uname.
  zdlpct_003-criado_em  = lv_criado_em.

ENDFORM.

FORM MODIFY_REGISTER.

ENDFORM.
