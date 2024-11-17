CLASS z2ui5_cl_demo_app_205 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_serializable_object.
    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_205 IMPLEMENTATION.

  METHOD display_view.

    DATA(page) = z2ui5_cl_xml_view=>factory( )->shell(
         )->page( title          = `abap2UI5 - Sample: Flex Box - Basic Alignment`
                  navbuttonpress = client->_event( 'BACK' )
                  shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ) ).

    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(layout) = page->vbox(
                   )->panel( headertext = `Upper left`
                   )->flex_box( height         = `100px`
                                alignItems     = `Start`
                                justifyContent = `Start`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Upper center`
                   )->flex_box( height         = `100px`
                                alignItems     = `Start`
                                justifyContent = `Center`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Upper right`
                   )->flex_box( height         = `100px`
                                alignItems     = `Start`
                                justifyContent = `End`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Middle left`
                   )->flex_box( height         = `100px`
                                alignItems     = `Center`
                                justifyContent = `Start`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Middle center`
                   )->flex_box( height         = `100px`
                                alignItems     = `Center`
                                justifyContent = `Center`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Middle right`
                   )->flex_box( height         = `100px`
                                alignItems     = `Center`
                                justifyContent = `End`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Lower left`
                   )->flex_box( height         = `100px`
                                alignItems     = `End`
                                justifyContent = `Start`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Lower center`
                   )->flex_box( height         = `100px`
                                alignItems     = `End`
                                justifyContent = `Center`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept` )->get_parent( )->get_parent(
                   )->panel( headertext = `Lower right`
                   )->flex_box( height         = `100px`
                                alignItems     = `End`
                                justifyContent = `End`
                              )->button( text  = `1`
                                         type  = `Emphasized`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text  = `2`
                                         type  = `Reject`
                                         class = `sapUiSmallMarginEnd`
                              )->button( text = `3`
                                         type = `Accept`
                   ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.

  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.

ENDCLASS.
