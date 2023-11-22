CLASS z2ui5_cl_demo_app_000 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA:
      BEGIN OF ms_check_expanded,
        basics     TYPE abap_bool,
        more       TYPE abap_bool,
        features   TYPE abap_bool,
        extensions TYPE abap_bool,
        demos      TYPE abap_bool,
      END OF ms_check_expanded.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mt_scroll TYPE z2ui5_if_client=>ty_t_name_value_int.

ENDCLASS.



CLASS z2ui5_cl_demo_app_000 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    IF client->get( )-check_on_navigated = abap_true.
      IF mt_scroll IS INITIAL.
        mt_scroll = VALUE #( ( n = `page` ) ).
      ENDIF.
      client->scroll_position_set( mt_scroll ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

      WHEN OTHERS.
        TRY.
            DATA(lv_classname) = to_upper( client->get( )-event ).
            DATA li_app TYPE REF TO z2ui5_if_app.
            CREATE OBJECT li_app TYPE (lv_classname).
            client->nav_app_call( li_app ).
            mt_scroll = client->get( )-t_scroll_pos.
            RETURN.
          CATCH cx_root.
        ENDTRY.
    ENDCASE.

    DATA(page) = z2ui5_cl_xml_view=>factory( client
        )->shell( )->page(
        id = `page`
        title = 'abap2UI5 - Samples'
        navbuttonpress = client->_event( val = 'BACK' check_view_destroy = abap_true )
        shownavbutton = abap_true
        )->header_content(
            )->toolbar_spacer(
            )->link( text = 'SCN'     target = '_blank' href = 'https://blogs.sap.com/tag/abap2ui5/'
            )->link( text = 'Twitter' target = '_blank' href = 'https://twitter.com/abap2UI5'
            )->link( text = 'GitHub'  target = '_blank' href = 'https://github.com/oblomov-dev/abap2ui5'
        )->get_parent( ).

    page = page->grid( 'L12 M12 S12'
         )->content( 'layout' ).

    page->formatted_text(
`<p><strong>Explore and copy code samples!</strong> All samples are abap2UI5 implementations of the <a href="https://sapui5.hana.ondemand.com/#/controls" style="color:blue; font-weight:600;">SAP UI5 sample page.</a> If you miss a control or find a b` &&
`ug please create an ` &&
`<a href="https://github.com/abap2UI5/abap2UI5/issues" style="color:blue; font-weight:600;">issue</a> or send a <a href="https://github.com/abap2UI5/abap2UI5-samples/pulls" style="color:blue; font-weight:600;">PR</a>` &&
`.</p>` ).

    DATA(page2) = page.

    page = page->panel(
     expandable = abap_true
     expanded   = client->_bind_edit( ms_check_expanded-basics ) "abap_false
*         height = `500px`
     headertext = `Basics - Input, Output & Popups`
).

    DATA(panel) = page->panel(
         expandable = abap_false
         expanded   = abap_true
         headertext = `General`
    ).

    panel->generic_tile(
        header    = 'Data Binding'
        subheader = 'Send values to the backend'
        press     = client->_event( 'Z2UI5_CL_DEMO_APP_001' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Controller'
        subheader = 'Handle events & change the view'
        press     = client->_event( 'Z2UI5_CL_DEMO_APP_004' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Flow Logic'
        subheader = 'Call other apps & exchange data'
        press     = client->_event( 'Z2UI5_CL_DEMO_APP_024' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

*    panel->generic_tile(
*        header    = 'Scrolling & Cursor'
*        subheader = ''
*        press     = client->_event( 'Z2UI5_CL_DEMO_APP_022' )
*        mode      = 'LineMode'
*        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
*    ).

    panel->generic_tile(
        header    = 'Timer'
        subheader = 'Wait n MS and call again the server'
        press     = client->_event( 'Z2UI5_CL_DEMO_APP_028' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

        panel->generic_tile(
        header    = 'Browser Title'
        press     = client->_event( 'z2ui5_cl_demo_app_125' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'New Tab'
        subheader = 'Open an URL in a new tab'
        press     = client->_event( 'Z2UI5_CL_DEMO_APP_073' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Focus & Cursor'
        press     = client->_event( 'z2ui5_cl_demo_app_133' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Scrolling'
        press     = client->_event( 'Z2UI5_CL_DEMO_APP_022' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel(
           expandable = abap_false
           expanded   = abap_true
           headertext = `Output`
      ).

    panel->generic_tile(
      header    = 'Code Editor'
       subheader = 'Display files'
      press     =  client->_event( 'Z2UI5_CL_DEMO_APP_035' )
      mode      = 'LineMode'
      class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile(
      header    = 'Rich Text Editor'
       subheader = 'Display files'
      press     =  client->_event( 'Z2UI5_CL_DEMO_APP_106' )
      mode      = 'LineMode'
      class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile(
         header    = 'Message I'
      subheader = 'Toast, Box & Strip'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_008' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).


    panel->generic_tile(
         header    = 'Message II'
        subheader = 'Illustrated Message'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_033' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
      header    = 'Message III'
        subheader = 'Message View & Popover'
      press     =  client->_event( 'Z2UI5_CL_DEMO_APP_038' )
      mode      = 'LineMode'
      class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).


    panel->generic_tile(
        header    = 'PDF Viewer'
        subheader = 'Display PDFs via iframe'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_079' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Formatted Text'
        subheader = 'Display HTML'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_015' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel(
        expandable = abap_false
        expanded   = abap_true
        headertext = 'Input Handling'
   ).


    panel->generic_tile(
        header    = 'Data Types'
        subheader = 'Use of Integer, Decimals, Dates & Time'
        press     = client->_event( 'Z2UI5_CL_DEMO_APP_047' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
      header    = 'Formatting'
      subheader = 'Currencies'
      press     = client->_event( 'Z2UI5_CL_DEMO_APP_067' )
      mode      = 'LineMode'
      class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile(
     header    = 'Input Validation'
     subheader = `Message Manager`
     press     = client->_event( 'Z2UI5_CL_DEMO_APP_084' )
     mode      = 'LineMode'
     class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile(
     header    = 'Mask Input'
     subheader = ``
     press     = client->_event( 'Z2UI5_CL_DEMO_APP_110' )
     mode      = 'LineMode'
     class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile(
    header    = 'Expression Binding'
    subheader = 'Use calculations & more functions directly in views'
    press     = client->_event( 'Z2UI5_CL_DEMO_APP_027' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).


    panel = page->panel(
        expandable = abap_false
        expanded   = abap_true
        headertext = 'Selection Screen'
   ).

    panel->generic_tile(
        header    = 'Basic'
        subheader = 'Explore input controls'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_002' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'More'
        subheader = 'Multi Input, Step Input, Text Are, Range Slider'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_005' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
       header    = 'Label'
       press     =  client->_event( 'Z2UI5_CL_DEMO_APP_051' )
       mode      = 'LineMode'
       class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile(
        header    = 'F4-Value-Help'
        subheader = 'Popup for value help'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_009' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
          header    = 'Search Field I'
          subheader = 'Filter with enter'
          press     =  client->_event( 'Z2UI5_CL_DEMO_APP_053' )
          mode      = 'LineMode'
          class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
      ).

    panel->generic_tile(
        header    = 'Search Field II'
        subheader = 'Filter with Live Change Event'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_059' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
     header    = 'Input with Filter'
     subheader = 'Filter Table on the Server'
     press     =  client->_event( 'Z2UI5_CL_DEMO_APP_059' )
     mode      = 'LineMode'
     class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile(
     header    = 'Input with Suggestion'
     subheader = 'Create Suggestion Table on the Server'
     press     =  client->_event( 'Z2UI5_CL_DEMO_APP_060' )
     mode      = 'LineMode'
     class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile(
      header    = 'Multi Input'
      subheader = ''
      press     =  client->_event( 'Z2UI5_CL_DEMO_APP_078' )
      mode      = 'LineMode'
      class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).


    panel->generic_tile(
       header    = 'Select-Options'
       subheader = 'Use multi inputs to create range tables'
       press     =  client->_event( 'Z2UI5_CL_DEMO_APP_056' )
       mode      = 'LineMode'
       class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile(
 header    = 'Feed Input'
 press     =  client->_event( 'Z2UI5_CL_DEMO_APP_101' )
 mode      = 'LineMode'
 class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
 header    = 'Timeline'
 press     =  client->_event( 'Z2UI5_CL_DEMO_APP_113' )
 mode      = 'LineMode'
 class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel(
             expandable = abap_false
             expanded   = abap_true
             headertext = `Popup & Popover`
        ).

    panel->generic_tile(
           header    = 'Popup'
        subheader = 'Simple Example'
           press     =  client->_event( 'Z2UI5_CL_DEMO_APP_021' )
           mode      = 'LineMode'
           class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile(
        header    = 'Flow Logic'
        subheader = 'Different ways of Popup handling'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_012' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Popover'
        subheader = 'Simple Example'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_026' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
         header    = 'Popover Item Level'
         subheader = 'Create a Popover for a specific entry of a table'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_052' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).


    panel->generic_tile(
         header    = 'Popover with List'
         subheader = 'List to select in Popover'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_081' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile(
         header    = 'Popover with Quick View'
         subheader = ''
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_109' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile(
         header    = 'Table Select Dialog'
         subheader = 'Popup for F4 Helps'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_087' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    page = page2->panel(
          expandable = abap_true
      expanded   = client->_bind_edit( ms_check_expanded-more )
          headertext = `More - Tables, Visualization & Layouts`
     ).

    panel = page->panel(
          expandable = abap_false
          expanded   = abap_true
          headertext = `Table`
     ).

    panel->generic_tile(
        header    = 'Toolbar'
        subheader = 'Add a container & toolbar'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_006' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Selection Modes'
        subheader = 'Single Select & Multi Select'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_019' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Editable'
        subheader = 'Set columns editable'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_011' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
         header    = 'Dynamic Types'
         subheader = 'Use RTTI to send tables to the frontend'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_061' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile(
         header    = 'Visualization'
         subheader = 'Object Number, Object States & Tab Filter'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_072' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile(
        header    = 'Layout'
        subheader = 'Save your table layout'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_058' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'ui.Table'
        subheader = 'Simple example'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_070' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).


    panel = page->panel(
           expandable = abap_false
           expanded   = abap_true
           headertext = `Lists & Trees`
      ).

    panel->generic_tile(
  header    = 'List I'
  subheader = 'Basic'
  press     =  client->_event( 'Z2UI5_CL_DEMO_APP_003' )
  mode      = 'LineMode'
  class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
    header    = 'List II'
    subheader = 'Events & Visualization'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_048' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).


    panel->generic_tile(
           header    = 'Tree Table I'
         subheader = 'Basic'
           press     =  client->_event( 'Z2UI5_CL_DEMO_APP_007' )
           mode      = 'LineMode'
           class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).


    panel->generic_tile(
        header    = 'Tree Table II'
        subheader = 'Popup Select Entry'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_068' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).



    panel = page->panel(
          expandable = abap_false
          expanded   = abap_true
          headertext = `Visualization`
     ).

    panel->generic_tile(
           header    = 'Donut Chart'
*        subheader = 'Use RTTI to send tables to the frontend'
           press     =  client->_event( 'Z2UI5_CL_DEMO_APP_013' )
           mode      = 'LineMode'
           class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).

    panel->generic_tile(
        header    = 'Line Chart'
*        subheader = 'sap.ui.Table'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_014' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Bar Chart'
*        subheader = 'sap.ui.Table'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_016' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
         header    = 'Radial Chart'
*subheader = 'sap.ui.Table'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_029' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile(
            header    = 'Monitor'
*subheader = 'sap.ui.Table'
            press     =  client->_event( 'Z2UI5_CL_DEMO_APP_041' )
            mode      = 'LineMode'
            class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
        ).

    panel->generic_tile(
        header    = 'Gantt Chart'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_076' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Planning Calender'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_080' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
    header    = 'Process Flow'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_091' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
    header    = 'Map Container'
    press     =  client->_event( 'z2ui5_cl_demo_app_123' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel = page->panel(
       expandable = abap_false
       expanded   = abap_true
       headertext = `Layouts`
  ).

    panel->generic_tile(
        header    = 'Header, Footer, Grid'
      subheader = 'Split view in different areas'
      press     =  client->_event( 'Z2UI5_CL_DEMO_APP_010' )
      mode      = 'LineMode'
      class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile(
        header    = 'Object Page'
         subheader = 'Display object details'
      press     =  client->_event( 'Z2UI5_CL_DEMO_APP_017' )
      mode      = 'LineMode'
      class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile(
        header    = 'Dynamic Page'
        subheader = 'Display items'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_030' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Flexible Column Layout'
        subheader = 'Master details with tree'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_069' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile(
        header    = 'Splitting Container'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_103' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile(
        header    = 'Side Panel'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_108' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    page = page2->panel(
          expandable = abap_true
           expanded   = client->_bind_edit( ms_check_expanded-features )
          headertext = `Features - Partial Rerendering & More`
     ).

    panel = page->panel(
               expandable = abap_false
               expanded   = abap_true
               headertext = `Partial Rerendering`
          ).

    panel->generic_tile(
        header    = 'Nested Views I'
        subheader = 'Basic Example'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_065' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Nested Views II'
        subheader = 'Master-Detail Page'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_066' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
    header    = 'Nested Views III'
    subheader = 'Head & Item Table'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_097' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
    header    = 'Nested Views IV'
    subheader = 'Head & Item Table & Detail'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_098' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
    header    = 'Nav Container I'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_088' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
        header    = 'Nav Container II'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_089' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel(
               expandable = abap_false
               expanded   = abap_true
               headertext = `Draft Handling`
          ).

    panel->generic_tile(
      header    = 'Draft I'
      subheader = 'App remembers at startup values of past inputs'
      press     =  client->_event( 'Z2UI5_CL_DEMO_APP_062' )
      mode      = 'LineMode'
      class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
  ).

    panel->generic_tile(
         header    = 'Draft II'
         subheader = 'Call the same app with different users'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_063' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel = page->panel(
               expandable = abap_false
               expanded   = abap_true
               headertext = `Features`
          ).

    panel->generic_tile(
       header    = 'Smallest App'
    subheader = 'Demo'
     press     =  client->_event( 'Z2UI5_CL_DEMO_APP_044' )
     mode      = 'LineMode'
     class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile(
      header    = 'Main App with Sub App I'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_095' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
      header    = 'Main App with Sub App II'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_104' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
      header    = 'Main App with Sub App III'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_126' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
     header    = 'Speed Test'
   press     =  client->_event( 'Z2UI5_CL_DEMO_APP_082' )
   mode      = 'LineMode'
   class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    page = page2->panel(
          expandable = abap_true
           expanded   = client->_bind_edit( ms_check_expanded-extensions )
          headertext = `Extensions`
     ).

    panel = page->panel(
               expandable = abap_false
               expanded   = abap_true
               headertext = `General`
          ).

    panel->generic_tile(
           header    = 'Create Views'
           subheader = 'Compare the three ways normal, generic & xml'
           press     =  client->_event( 'Z2UI5_CL_DEMO_APP_023' )
           mode      = 'LineMode'
           class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
       ).


    panel->generic_tile(
        header    = 'Import View'
         subheader = 'Copy & paste views of the UI5 Documentation'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_031' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Custom Control'
         subheader = 'Integrate your own JS Custom Control'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_037' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
         header    = 'Change CSS'
         subheader = 'Send your own CSS to the frontend'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_050' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).


    panel->generic_tile(
        header    = 'HTML, JS, CSS'
        subheader = 'Display normal HTML without UI5'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_032' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Canvas & SVG'
         subheader = 'Integrate more HTML5 functionalities'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_036' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
         header    = 'Ext. Library'
         subheader = 'Load external JS libraries'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_040' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel->generic_tile(
         header    = 'Custom Function'
         subheader = 'Call imported function'
         press     =  client->_event( 'Z2UI5_CL_DEMO_APP_093' )
         mode      = 'LineMode'
         class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
     ).

    panel = page->panel(
           expandable = abap_false
           expanded   = abap_true
           headertext = `Apps with add. Javascript`
      ).

    panel->generic_tile(
     header    = 'p13n Dialog'
     subheader = 'Popup for F4 Helps'
     press     =  client->_event( 'Z2UI5_CL_DEMO_APP_090' )
     mode      = 'LineMode'
     class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).


    panel->generic_tile(
     header    = 'Upload Set'
     subheader = ''
     press     =  client->_event( 'Z2UI5_CL_DEMO_APP_107' )
     mode      = 'LineMode'
     class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel->generic_tile(
     header    = 'Smart Variant Management'
     subheader = ''
     press     =  client->_event( 'Z2UI5_CL_DEMO_APP_111' )
     mode      = 'LineMode'
     class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
 ).

    panel = page->panel(
           expandable = abap_false
           expanded   = abap_true
           headertext = `Custom Control - File API`
      ).

    panel->generic_tile(
    header    = 'Download CSV'
    subheader = 'Export Table as CSV'
    press     =  client->_event( 'Z2UI5_CL_DEMO_APP_057' )
    mode      = 'LineMode'
    class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
       header    = 'Upload CSV'
       subheader = 'Import CSV as internal Table'
       press     =  client->_event( 'Z2UI5_CL_DEMO_APP_074' )
       mode      = 'LineMode'
       class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
   ).

    panel->generic_tile(
        header    = 'File Uploader'
        subheader = 'Upload any file to the Backend'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_075' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).


    panel = page->panel(
            expandable = abap_false
            expanded   = abap_true
            headertext = `Custom Control - More`
       ).

    panel->generic_tile(
        header    = 'Spreadsheet Control'
        subheader = 'Export Table as XLSX'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_077' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Generate Barcodes'
        subheader = 'bwip-js'
        press     =  client->_event( 'z2ui5_cl_demo_app_102' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel->generic_tile(
        header    = 'Tours & Contectual Help'
        subheader = 'driver.js'
        press     =  client->_event( 'z2ui5_cl_demo_app_119' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).

    panel = page->panel(
            expandable = abap_false
            expanded   = abap_true
            headertext = `Device Capabilities & More`
       ).

    panel->generic_tile(
header    = 'Geolocation'
subheader = ''
press     =  client->_event( 'z2ui5_cl_demo_app_120' )
mode      = 'LineMode'
class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    panel->generic_tile(
header    = 'Frontend Infos'
subheader = ''
press     =  client->_event( 'z2ui5_cl_demo_app_122' )
mode      = 'LineMode'
class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).


    panel->generic_tile(
 header    = 'Barcode Scanner'
 subheader = 'ndc.Barcode'
 press     =  client->_event( 'z2ui5_cl_demo_app_124' )
 mode      = 'LineMode'
 class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
).

    page = page2->panel(
          expandable = abap_true
           expanded   = client->_bind_edit( ms_check_expanded-demos )
          headertext = `Demos`
     ).

*    panel = page->panel(
*               expandable = abap_false
*               expanded   = abap_true
*               headertext = `Apps`
*          ).

    page->generic_tile(
        header    = 'Demo I'
        subheader = 'Nested View, Object Page, App Navigation, Tables, Lists, Images, Progress & Rating Indicator'
        press     =  client->_event( 'Z2UI5_CL_DEMO_APP_085' )
        mode      = 'LineMode'
        class     = 'sapUiTinyMarginEnd sapUiTinyMarginBottom'
    ).


    client->view_display( page->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
