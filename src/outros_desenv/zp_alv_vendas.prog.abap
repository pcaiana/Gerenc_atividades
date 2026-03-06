*&---------------------------------------------------------------------*
*& Report ZP_ALV_VENDAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zp_alv_vendas.

TABLES: zdlt_001, zdlt_002.

* screen
** tela de parceiro
SELECTION-SCREEN BEGIN OF SCREEN 110 AS SUBSCREEN.
  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

    SELECT-OPTIONS: s_parc FOR zdlt_002-parceiro,
                    s_nome FOR zdlt_002-nome.
    SELECTION-SCREEN SKIP.
    PARAMETERS: p_all RADIOBUTTON GROUP g1 DEFAULT 'X',
                p_loj RADIOBUTTON GROUP g1,
                p_ban RADIOBUTTON GROUP g1.

  SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN END OF SCREEN 110.

** tela de produto
SELECTION-SCREEN BEGIN OF SCREEN 120 AS SUBSCREEN.
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

    SELECT-OPTIONS: s_prod FOR zdlt_001-produto,
                    s_desc FOR zdlt_001-descricao.

  SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF SCREEN 120.

SELECTION-SCREEN BEGIN OF TABBED BLOCK tab_block FOR 13 LINES.
  SELECTION-SCREEN TAB (20) tab1 USER-COMMAND comm1 DEFAULT SCREEN 110.
  SELECTION-SCREEN TAB (20) tab2 USER-COMMAND comm2 DEFAULT SCREEN 120.
SELECTION-SCREEN END OF BLOCK tab_block.

* class
CLASS lcl_main DEFINITION.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_filter,
             s_parc TYPE RANGE OF zdlt_002-parceiro,
             s_nome TYPE RANGE OF zdlt_002-nome,
             s_prod TYPE RANGE OF zdlt_001-produto,
             s_desc TYPE RANGE OF zdlt_001-descricao,
             p_all  TYPE xfeld,
             p_loj  TYPE xfeld,
             p_ban  TYPE xfeld,
           END OF ty_filter.

    DATA: v_dynnr   TYPE dynnr.
    CLASS-DATA: v_filters TYPE ty_filter.

    DATA: it_parceiros TYPE TABLE OF zdlt_002,
          it_produtos  TYPE TABLE OF zdlt_001.


    CLASS-METHODS create
      RETURNING VALUE(r_result) TYPE REF TO lcl_main.

    METHODS: run IMPORTING VALUE(_dynnr) TYPE dynnr VALUE(_filter) TYPE ty_filter,
      run_parceiros,
      get_parceiros,
      display_alv_parceiros,
      run_produtos,
      get_produtos,
      display_alv_produtos.
*      display_alv.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD create.

    CREATE OBJECT r_result.

  ENDMETHOD.

  METHOD run .

    me->v_dynnr = _dynnr.
    me->v_filters = _filter.

    CASE me->v_dynnr.
      WHEN '0110'.
        me->run_parceiros( ).
      WHEN '0120'.
        me->run_produtos( ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  METHOD run_parceiros.
    me->get_parceiros( ).
    me->display_alv_parceiros( ).
  ENDMETHOD.

  METHOD get_parceiros.

    DATA: r_tipo TYPE rseloption.

    IF me->v_filters-p_all EQ abap_true.

      r_tipo = VALUE rseloption(
       ( sign = 'I' option = 'EQ' low = 'L' )
       ( sign = 'I' option = 'EQ' low = 'B' )
       ( sign = 'I' option = 'EQ' low = 'C' )
      ).
    ELSEIF me->v_filters-p_ban EQ abap_true.
      r_tipo = VALUE rseloption(
    ( sign = 'I' option = 'EQ' low = 'B' ) ).
    ELSE.
      r_tipo = VALUE rseloption(
    ( sign = 'I' option = 'EQ' low = 'L' ) )  .

    ENDIF.

    SELECT *
      FROM zdlt_002
      INTO TABLE me->it_parceiros
      WHERE parceiro IN me->v_filters-s_parc
      AND nome IN me->v_filters-s_nome
      AND tipo_parceiro IN r_tipo.

  ENDMETHOD.

  METHOD display_alv_parceiros.

    cl_salv_table=>factory(
           IMPORTING
             r_salv_table = DATA(alv_table)
             CHANGING
               t_table = me->it_parceiros ).

    alv_table->display( ).

  ENDMETHOD.

  METHOD run_produtos.
    me->get_produtos( ).
    me->display_alv_produtos( ).
  ENDMETHOD.

  METHOD get_produtos.

    SELECT *
      FROM zdlt_001
      INTO TABLE me->it_produtos
      WHERE produto IN me->v_filters-s_prod
      AND   descricao IN me->v_filters-s_desc.

  ENDMETHOD.

  METHOD display_alv_produtos.

    cl_salv_table=>factory(
             IMPORTING
               r_salv_table = DATA(alv_table)
               CHANGING
                 t_table = me->it_produtos ).

    alv_table->display( ).

  ENDMETHOD.

*  METHOD display_alv.
*
*    CASE me->v_dynnr.
*      WHEN '0110'.
*        cl_salv_table=>factory(
*           IMPORTING
*             r_salv_table = DATA(alv_table)
*             CHANGING
*               t_table = me->it_parceiros ).
*      WHEN '0120'.
*        cl_salv_table=>factory(
*           IMPORTING
*             r_salv_table = alv_table
*             CHANGING
*               t_table = me->it_produtos ).
*      WHEN OTHERS.
*    ENDCASE.
*
*    alv_table->display( ).
*
*  ENDMETHOD.

ENDCLASS.

* events

INITIALIZATION.

  tab1 = 'Parceiros'(020).
  tab2 = 'Produtos'(020).

START-OF-SELECTION.

  lcl_main=>create( )->run(
    _dynnr = tab_block-dynnr
    _filter = VALUE lcl_main=>ty_filter(
       s_parc = s_parc[]
       s_nome = s_nome[]
       s_prod = s_prod[]
       s_desc = s_desc[]
       p_all  = p_all
       p_loj  = p_loj
       p_ban  = p_ban
         ) ).
