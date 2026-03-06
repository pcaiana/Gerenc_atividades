
*********************************************************************************
** Programa :
** Autor          :  Paulo Caiana
** Descrição:
** Data           : 06.03.2026 07:04:26
*********************************************************************************
*
REPORT zrp_voos.

CLASS lcl_main DEFINITION CREATE PRIVATE.


  PUBLIC SECTION.

    CLASS-METHODS create
      RETURNING VALUE(r_result) TYPE REF TO lcl_main.

    DATA: selections TYPE REF TO cl_salv_selections.

    METHODS : run,
      on_user_command FOR EVENT added_function OF cl_salv_events
        IMPORTING e_salv_function.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD create.
    CREATE OBJECT r_result.
  ENDMETHOD.

  METHOD run.

    SELECT *
      FROM sflight
      UP TO 20 ROWS
      INTO TABLE @DATA(lt_voos).

    cl_salv_table=>factory(
       IMPORTING
         r_salv_table = DATA(alv_table)
         CHANGING
           t_table    = lt_voos
    ).
*
    selections = alv_table->get_selections( ).
    selections->set_selection_mode( if_salv_c_selection_mode=>row_column ).

    DATA(events) = alv_table->get_event( ).
    SET HANDLER me->on_user_command FOR events.

    alv_table->set_screen_status(
      EXPORTING
        pfstatus = 'STANDARD'
        report   = sy-repid
        set_functions = alv_table->c_functions_all
    ).

    alv_table->display( ).





  ENDMETHOD.

  METHOD on_user_command.

    DATA(lt_rows) = selections->get_selected_rows( ).

    CASE e_salv_function.
      WHEN 'ALERT'.
        MESSAGE |Botão clicado com sucesso!| TYPE 'S'.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  lcl_main=>create( )->run( ).
