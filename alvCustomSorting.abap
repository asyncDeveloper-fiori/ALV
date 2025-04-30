*&---------------------------------------------------------------------*
*& Report ZALV7_U41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalv7_u41.

TABLES : vbak .

TYPES : BEGIN OF ty_vbak,
          vbeln TYPE vbak-vbeln,
          erdat TYPE vbak-erdat,
          ernam TYPE vbak-ernam,
          erzet TYPE vbak-erzet,
        END OF ty_vbak.

DATA : lt_vbak TYPE TABLE OF ty_vbak,
       lt_sort TYPE slis_t_sortinfo_alv,
       wa_Sort TYPE slis_sortinfo_alv,
       lt_fieldcat TYPE slis_t_fieldcat_alv,
       wa_fieldcat TYPE slis_fieldcat_alv.

SELECT * FROM vbap INTO CORRESPONDING FIELDS OF TABLE lt_vbak.

  wa_sort-fieldname = 'VBELN'.
  wa_sort-down = abap_true.
  append wa_Sort to lt_sort.
  clear wa_sort.

  wa_fieldcat-col_pos = 1.
wa_fieldcat-fieldname = 'VBELN'.
wa_fieldcat-tabname = 'LT_VBAK'.
wa_fieldcat-seltext_m = 'Sales doc number'.
APPEND wa_fieldcat to lt_fieldcat.
clear : wa_fieldcat.

wa_fieldcat-col_pos = 2.
wa_fieldcat-fieldname = 'ERDAT'.
wa_fieldcat-tabname = 'LT_VBAK'.
wa_fieldcat-seltext_m = 'Creation date'.
APPEND wa_fieldcat to lt_fieldcat.
clear : wa_fieldcat.

wa_fieldcat-col_pos = 3.
wa_fieldcat-fieldname = 'ERNAM'.
wa_fieldcat-tabname = 'LT_VBAK'.
wa_fieldcat-seltext_m = 'Creation name'.
APPEND wa_fieldcat to lt_fieldcat.
clear : wa_fieldcat.

wa_fieldcat-col_pos = 4.
wa_fieldcat-fieldname = 'ERZET'.
wa_fieldcat-tabname = 'LT_VBAK'.
wa_fieldcat-seltext_m = 'ERZET'.
APPEND wa_fieldcat to lt_fieldcat.
clear : wa_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
   EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
*     I_CALLBACK_PROGRAM                = ' '
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
*     I_GRID_TITLE                      =
*     I_GRID_SETTINGS                   =
*     IS_LAYOUT                         =
     IT_FIELDCAT                       = lt_fieldcat
*     IT_EXCLUDING                      =
*     IT_SPECIAL_GROUPS                 =
     IT_SORT                           = lt_sort
*     IT_FILTER                         =
*     IS_SEL_HIDE                       =
*     I_DEFAULT                         = 'X'
*     I_SAVE                            = ' '
*     IS_VARIANT                        =
*     IT_EVENTS                         =
*     IT_EVENT_EXIT                     =
*     IS_PRINT                          =
*     IS_REPREP_ID                      =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS                   =
*     IT_HYPERLINK                      =
*     IT_ADD_FIELDCAT                   =
*     IT_EXCEPT_QINFO                   =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER           =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab                          = lt_vbak
   EXCEPTIONS
     PROGRAM_ERROR                     = 1
     OTHERS                            = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
