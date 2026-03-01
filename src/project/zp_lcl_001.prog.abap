*&---------------------------------------------------------------------*
*& Report ZP_LCL_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zp_lcl_001.

CLASS lcl_first DEFINITION.

* public section - sessão publica
  PUBLIC SECTION.
    DATA: nome_pub TYPE string VALUE '__Nome Publico__'.

    METHODS: write_nome_pro,
      write_nome_pri.

* protecte section - sessão protegida
  PROTECTED SECTION.
    DATA: nome_pro TYPE string VALUE '__Nome Protegido__'.

* private section - sessão privada
  PRIVATE SECTION.
    DATA: nome_pri TYPE string VALUE '__Nome Privado__'.

ENDCLASS.

CLASS lcl_first IMPLEMENTATION.

  METHOD write_nome_pro.
     WRITE: / 'Nome Protegido ->', me->nome_pro.
  ENDMETHOD.

  METHOD write_nome_pri.
     WRITE: / 'Nome Privado ->', me->nome_pri.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA(lo_first) = NEW lcl_first( ).
  WRITE: / 'Nome Publico ->', lo_first->nome_pub.

  lo_first->write_nome_pri( ).
  lo_first->write_nome_pro( ).
