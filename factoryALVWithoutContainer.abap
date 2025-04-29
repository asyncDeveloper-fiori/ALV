*&---------------------------------------------------------------------*
*& Report ZALV_FACTORY1_U41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalv_factory1_u41.

TYPES : BEGIN OF ty_sflight,
          carrid   TYPE sflight-carrid,
          connid   TYPE sflight-connid,
          fldate   TYPE sflight-fldate,
          seatsmax TYPE sflight-seatsmax,
        END OF ty_sflight.

DATA : lt_sflight TYPE TABLE OF ty_sflight,
       wa_sflight TYPE ty_sflight,
       lo_alv type ref to CL_SALV_TABLE.

SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE lt_sflight UP TO 20 ROWS .

  TRY.
  CALL METHOD cl_salv_table=>factory
    IMPORTING
      r_salv_table   = lo_alv
    CHANGING
      t_table        = lt_sflight
      .
    CATCH cx_salv_msg.
  ENDTRY.


  call METHOD lo_alv->display( ).
