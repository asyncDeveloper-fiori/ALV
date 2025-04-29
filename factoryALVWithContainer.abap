*&---------------------------------------------------------------------*
*& Report ZALV_FACTORY2_U41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalv_factory2_u41.

* using tables
TABLES : sflight.

* local structure for sflight table
TYPES : BEGIN OF ty_sflight,
          carrid     TYPE sflight-carrid,
          connid     TYPE sflight-connid,
          seatsmax   TYPE sflight-seatsmax,
          seatsmax_b TYPE sflight-seatsmax_b,
        END OF ty_Sflight.

*        declare internal table and work area

DATA : lt_sflight TYPE TABLE OF ty_Sflight,
       wa_sflight TYPE ty_sflight.

* object defination for container
data : lo_container type ref to cl_gui_custom_container.

* object defination of cl_Salv_table
data : lo_table type REF TO cl_salv_table.

* main logic starts
START-OF-SELECTION.

* fetch data
  SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE lt_sflight UP TO 10 ROWS.

*    object creation
    create OBJECT lo_container
    EXPORTING
      container_name = 'CONT'.


* calling class and method
TRY.
CALL METHOD cl_salv_table=>factory
  EXPORTING
*    list_display   = IF_SALV_C_BOOL_SAP=>FALSE
    r_container    = lo_container
    container_name = 'CONT'
  IMPORTING
    r_salv_table   = lo_table
  CHANGING
    t_table        = lt_sflight
    .
  CATCH cx_salv_msg.
ENDTRY.


call METHOD lo_table->display( ).

call SCREEN '0100'.


end-of-SELECTION.
