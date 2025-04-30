*&---------------------------------------------------------------------*
*& Report ZALV6_U41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalv6_u41.

TABLES : vbak.

TYPES: BEGIN OF ty_vbak,
         vbeln TYPE vbeln_va,
         ernam TYPE ernam,
         erdat TYPE erdat,
         vbtyp TYPE vbtypl,
       END OF ty_vbak.

TYPES : BEGIN OF ty_vbap,
          vbeln TYPE vbeln_va,
          posnr TYPE posnr_va,
          matnr TYPE matnr,
          matwa TYPE matwa,
        END OF ty_vbap.

DATA : lt_vbak TYPE TABLE OF ty_vbak,
       wa_vbak TYPE ty_vbak,
       lt_vbap TYPE TABLE OF ty_vbap,
       wa_vbap TYPE ty_vbap.

DATA : lt_final TYPE TABLE OF zst_final1_u41,
       wa_final TYPE zst_final1_u41.

SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : s_vbeln FOR vbak-vbeln.
SELECTION-SCREEN : END OF BLOCK b1.

START-OF-SELECTION.
  SELECT vbeln ernam erdat vbtyp FROM vbak INTO TABLE lt_vbak WHERE  vbeln IN s_vbeln.


  IF lt_vbak IS NOT INITIAL.
    SELECT vbeln posnr matnr matwa FROM vbap INTO TABLE lt_vbap FOR ALL ENTRIES IN lt_vbak WHERE vbeln = lt_vbak-vbeln.
  ENDIF.

  LOOP AT lt_vbak INTO wa_vbak.
    LOOP AT lt_vbap INTO wa_vbap WHERE vbeln EQ wa_vbak-vbeln.
      wa_final-vbeln = wa_vbak-vbeln.
      wa_final-ernam = wa_vbak-ernam.
      wa_final-erdat = wa_vbak-erdat.
      wa_final-vbtyp = wa_vbak-vbtyp.
      wa_final-posnr = wa_vbap-posnr.
      wa_final-matnr = wa_vbap-matnr.
      wa_final-matwa = wa_vbap-matwa.
      APPEND wa_final TO lt_final.
      CLEAR wa_final.
    ENDLOOP.
  ENDLOOP.

  DATA  : lt_fieldcat TYPE slis_t_fieldcat_alv.

CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
 EXPORTING
*   I_PROGRAM_NAME               =
*   I_INTERNAL_TABNAME           =
   I_STRUCTURE_NAME             = 'ZST_FINAL1_U41'
*   I_CLIENT_NEVER_DISPLAY       = 'X'
*   I_INCLNAME                   =
*   I_BYPASSING_BUFFER           =
*   I_BUFFER_ACTIVE              =
  CHANGING
    ct_fieldcat                  = lt_fieldcat
 EXCEPTIONS
   INCONSISTENT_INTERFACE       = 1
   PROGRAM_ERROR                = 2
   OTHERS                       = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
*   I_CALLBACK_PROGRAM                = ' '
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
*   IS_LAYOUT                         =
   IT_FIELDCAT                       = lt_fieldcat
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab                          = lt_final
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
