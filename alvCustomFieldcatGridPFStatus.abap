*&---------------------------------------------------------------------*
*& Report ZASSIGN_ALV13_2_U41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zassign_alv13_2_u41.

DATA: lt_emp      TYPE TABLE OF zemployee_u41,
      wa_emp      TYPE zemployee_u41,

      lt_tblcp    TYPE STANDARD TABLE OF zemployee_u41,
      lt_changes  TYPE STANDARD TABLE OF zemployee_u41,

      lt_fieldcat TYPE slis_t_fieldcat_alv,
      wa_fieldcat TYPE slis_fieldcat_alv,

      lt_layout   TYPE slis_layout_alv,

      lt_sort     TYPE slis_t_sortinfo_alv,
      wa_sort     TYPE slis_sortinfo_alv.

*START-OF-SELECTION.
PERFORM get_data.
PERFORM get_layout.
PERFORM get_fieldcat.
PERFORM display_data.

FORM get_data.
  SELECT * FROM zemployee_u41 INTO CORRESPONDING FIELDS OF TABLE lt_emp.
  lt_tblcp[] = lt_emp[].
ENDFORM.

FORM get_fieldcat.
  CLEAR wa_fieldcat.
  wa_fieldcat-col_pos = 1.
  wa_fieldcat-fieldname = 'EMP_ID'.
  wa_fieldcat-key = abap_true.
  wa_fieldcat-tabname = 'lt_emp'.
  wa_fieldcat-seltext_m = 'Employee ID'.
  APPEND wa_fieldcat TO lt_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-col_pos = 2.
  wa_fieldcat-fieldname = 'NAME'.
  wa_fieldcat-tabname = 'lt_emp'.
  wa_fieldcat-seltext_m = 'Employee name'.
  APPEND wa_fieldcat TO lt_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-col_pos = 3.
  wa_fieldcat-fieldname = 'POSITION_L'.
  wa_fieldcat-tabname = 'lt_emp'.
  wa_fieldcat-seltext_m = 'Position'.
  APPEND wa_fieldcat TO lt_fieldcat.

  CLEAR wa_fieldcat.

  wa_sort-fieldname = 'EMP_ID'.
  wa_sort-up = 'X'.
  APPEND wa_sort TO lt_sort.
ENDFORM.

FORM display_data.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK        = ' '
*     I_BYPASSING_BUFFER       = ' '
*     I_BUFFER_ACTIVE          = ' '
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'P_STATUS' "You can give any name here AND create subroutine with this
      i_callback_user_command  = 'USER-COMM' " You have to create the subroutine with this name with the same as how sap created
*     I_CALLBACK_TOP_OF_PAGE   = ''
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
      i_structure_name         = 'ZEMPLOYEE_U41'
*     I_BACKGROUND_ID          = ' '
*     I_GRID_TITLE             = ''
*     I_GRID_SETTINGS          =
      is_layout                = lt_layout
      it_fieldcat              = lt_fieldcat
*     IT_EXCLUDING             =
*     IT_SPECIAL_GROUPS        =
      it_sort                  = lt_sort
*     IT_FILTER                =
*     IS_SEL_HIDE              =
*     I_DEFAULT                = 'X'
*     i_save                   = 'A'
*     IS_VARIANT               =
*     IT_EVENTS                =
*     IT_EVENT_EXIT            =
*     IS_PRINT                 =
*     IS_REPREP_ID             =
*     I_SCREEN_START_COLUMN    = 0
*     I_SCREEN_START_LINE      = 0
*     I_SCREEN_END_COLUMN      = 0
*     I_SCREEN_END_LINE        = 0
*     I_HTML_HEIGHT_TOP        = 0
*     I_HTML_HEIGHT_END        = 0
*     IT_ALV_GRAPHICS          =
*     IT_HYPERLINK             =
*     IT_ADD_FIELDCAT          =
*     IT_EXCEPT_QINFO          =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER  =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER  =
*     ES_EXIT_CAUSED_BY_USER   =
    TABLES
      t_outtab                 = lt_emp
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.

FORM get_layout.
  lt_layout-zebra = 'X'.
  lt_layout-edit = abap_true.
ENDFORM.

FORM p_status USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'ZMENU_U41'.
ENDFORM.


*lt_tblcp    TYPE TABLE OF ztblu28_3,
*lt_changes  TYPE TABLE OF ztblu28_3,
FORM user-comm USING r_ucomm LIKE sy-ucomm rs_selfield TYPE slis_selfield.
  CASE r_ucomm.
    WHEN 'PUSHDATA'.
      DATA : wa_tblcp      TYPE zemployee_u41,
             wa_tblcp_temp TYPE zemployee_u41.

      CLEAR lt_changes[].

      LOOP AT lt_emp INTO wa_emp.
        READ TABLE lt_tblcp INTO wa_tblcp INDEX sy-tabix.
        IF wa_tblcp NE wa_emp.
          APPEND wa_emp TO lt_changes.
          MOVE-CORRESPONDING wa_emp TO wa_tblcp_temp.
          MODIFY zemployee_u41 FROM wa_tblcp_temp.
        ENDIF.
        CLEAR wa_tblcp.
      ENDLOOP.
      write / 'Done'.
  ENDCASE.
ENDFORM.
