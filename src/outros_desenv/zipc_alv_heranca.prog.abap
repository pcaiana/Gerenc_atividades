*&---------------------------------------------------------------------*
*& Report ZIPC_ALV_HERANCA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zipc_alv_heranca.

INCLUDE zipc_global_view.

CLASS lcl_main DEFINITION CREATE PRIVATE INHERITING FROM global_view_alv.

  PUBLIC SECTION.

    CLASS-METHODS create
      RETURNING VALUE(r_result) TYPE REF TO lcl_main.

    METHODS run.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD create.
    CREATE OBJECT r_result.
  ENDMETHOD.

  METHOD run.

    SELECT *
      UP TO 30 ROWS
      FROM sflight
      INTO TABLE @DATA(it_sflight).

    me->display_alv( CHANGING _data = it_sflight ).
    alv->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  lcl_main=>create( )->run( ).
