class ZLC_API_TESTE definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZLC_API_TESTE IMPLEMENTATION.


  METHOD if_http_extension~handle_request.

    DATA(lv_type_crud) = server->request->get_header_field( name = '~request_method' ).

    CASE lv_type_crud.
      WHEN 'GET'.
*       selecionar dados
        SELECT matnr, ernam, mtart, ntgew, laeda, pstat
          INTO TABLE @DATA(lt_mara)
          FROM mara
          UP TO 10 ROWS.

        IF sy-subrc EQ 0.
*            converter tabela em json
          DATA(lt_json_response) = /ui2/cl_json=>serialize( EXPORTING data = lt_mara ).
*            retornar na API
          server->response->set_cdata( data = lt_json_response ).
        ENDIF.

      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
