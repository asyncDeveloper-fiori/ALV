*&---------------------------------------------------------------------*
*& Report ZALV3_U41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALV3_U41.

* import table vbak for data retrival
tables : vbak.


* include program
include zavl_form.


* user input
SELECTION-SCREEN : BEGIN OF block b1 WITH FRAME TITLE text-001.
  select-OPTIONS : s_vbeln for vbak-vbeln.
  SELECTION-SCREEN : end of block b1.

*  perform the operation in include program
PERFORM fetch using s_vbeln[].


*include program 
*&---------------------------------------------------------------------*
*& Include          ZAVL_FORM
*&---------------------------------------------------------------------*

form fetch using s_vbeln type ztabtype_sopn_u41.
  data : lt_vbak type table of vbak.


  select * from vbak into CORRESPONDING FIELDS OF table lt_vbak where vbeln in s_vbeln.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
     EXPORTING
*       I_INTERFACE_CHECK                 = ' '
*       I_BYPASSING_BUFFER                = ' '
*       I_BUFFER_ACTIVE                   = ' '
*       I_CALLBACK_PROGRAM                = ' '
*       I_CALLBACK_PF_STATUS_SET          = ' '
*       I_CALLBACK_USER_COMMAND           = ' '
*       I_CALLBACK_TOP_OF_PAGE            = ' '
*       I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*       I_CALLBACK_HTML_END_OF_LIST       = ' '
       I_STRUCTURE_NAME                  = 'VBAK'
*       I_BACKGROUND_ID                   = ' '
*       I_GRID_TITLE                      =
*       I_GRID_SETTINGS                   =
*       IS_LAYOUT                         =
*       IT_FIELDCAT                       =
*       IT_EXCLUDING                      =
*       IT_SPECIAL_GROUPS                 =
*       IT_SORT                           =
*       IT_FILTER                         =
*       IS_SEL_HIDE                       =
*       I_DEFAULT                         = 'X'
*       I_SAVE                            = ' '
*       IS_VARIANT                        =
*       IT_EVENTS                         =
*       IT_EVENT_EXIT                     =
*       IS_PRINT                          =
*       IS_REPREP_ID                      =
*       I_SCREEN_START_COLUMN             = 0
*       I_SCREEN_START_LINE               = 0
*       I_SCREEN_END_COLUMN               = 0
*       I_SCREEN_END_LINE                 = 0
*       I_HTML_HEIGHT_TOP                 = 0
*       I_HTML_HEIGHT_END                 = 0
*       IT_ALV_GRAPHICS                   =
*       IT_HYPERLINK                      =
*       IT_ADD_FIELDCAT                   =
*       IT_EXCEPT_QINFO                   =
*       IR_SALV_FULLSCREEN_ADAPTER        =
*       O_PREVIOUS_SRAL_HANDLER           =
*     IMPORTING
*       E_EXIT_CAUSED_BY_CALLER           =
*       ES_EXIT_CAUSED_BY_USER            =
      TABLES
        t_outtab                          = lt_vbak
*     EXCEPTIONS
*       PROGRAM_ERROR                     = 1
*       OTHERS                            = 2
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDFORM.
