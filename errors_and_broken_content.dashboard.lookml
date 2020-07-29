- dashboard: errors_and_broken_content
  title: Errors and Broken Content
  layout: newspaper
  elements:
  - title: Broken Schedules
    name: Broken Schedules
    model: system__activity
    explore: scheduled_plan
    type: table
    fields: [scheduled_job.finalized_date, scheduled_job.name, scheduled_job.status_detail,
      scheduled_plan.content_link, scheduled_plan.space_link, scheduled_job.user_id,
      user.name]
    filters:
      scheduled_job.status: failure
    sorts: [scheduled_job.finalized_date desc]
    limit: 100
    query_timezone: America/Los_Angeles
    column_order: [scheduled_job.name, scheduled_job.status_detail, user.name, scheduled_job.finalized_date,
      scheduled_plan.content_link, scheduled_plan.space_link]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      user.name: Creator
      scheduled_job.finalized_date: Job Date
    series_column_widths:
      scheduled_job.finalized_date: 100
      user.name: 200
      scheduled_job.status_detail: 550
      scheduled_plan.content_link: 150
      scheduled_job.name: 275
      scheduled_plan.space_link: 213
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_types: {}
    hidden_fields: [scheduled_job.user_id]
    listen: {}
    row: 7
    col: 0
    width: 24
    height: 7
  - title: Broken Dashboard Content
    name: Broken Dashboard Content
    model: system__activity
    explore: history
    type: table
    fields: [dashboard.title, dashboard.link, history.real_dash_id, history.message,
      history.issuer_source, history.count, history.dashboard_user]
    filters:
      history.status: error
      history.source: Dashboard
      history.message: "-Access Denied"
      history.workspace_id: "-dev"
      history.created_date: 90 days
    sorts: [history.count desc]
    limit: 100
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    pinned_columns: {}
    column_order: [dashboard.title, history.message, history.dashboard_user, dashboard.link,
      history.issuer_source]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      history.dashboard_user: Impacted Users
      dashboard_creator.name: Creator
    series_column_widths:
      history.real_dash_id: 59
      dashboard.link: 150
      history.message: 550
      dashboard_creator.name: 123
      history.dashboard_user: 300
      dashboard.title: 275
      history.issuer_source: 215
    series_cell_visualizations:
      history.dashboard_user:
        is_active: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    series_types: {}
    hidden_fields: [history.count, history.real_dash_id]
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 7
  - title: Broken Looks
    name: Broken Looks
    model: system__activity
    explore: history
    type: table
    fields: [look.title, look.link, history.id, history.status, history.message, history.issuer_source,
      history.source, history.count, user.name]
    filters:
      history.status: error
      history.source: Saved Look
      history.workspace_id: "-dev"
    sorts: [history.count desc]
    limit: 100
    query_timezone: America/Los_Angeles
    column_order: [look.title, history.message, user.name, history.id, look.link,
      history.issuer_source]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_column_widths:
      look.title: 275
      history.message: 550
      user.name: 200
      history.id: 100
      look.link: 150
      history.issuer_source: 209
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    series_types: {}
    hidden_fields: [history.status, history.source, history.count]
    listen: {}
    row: 14
    col: 0
    width: 24
    height: 7
  - title: PDT Failures
    name: PDT Failures
    model: system__activity
    explore: pdt_event_log
    type: table
    fields: [pdt_event_log.view_name, pdt_event_log.model_name, pdt_event_log.action,
      pdt_event_log.action_data, pdt_event_log.connection, pdt_event_log.pdt_create_failures,
      pdt_event_log.pdt_trigger_failures]
    filters:
      pdt_event_log.pdt_create_failures: ">0"
    sorts: [pdt_event_log.pdt_create_failures desc]
    limit: 100
    query_timezone: America/Los_Angeles
    column_order: [pdt_event_log.view_name, pdt_event_log.model_name, pdt_event_log.action,
      pdt_event_log.action_data, pdt_event_log.pdt_create_failures, pdt_event_log.connection,
      pdt_event_log.pdt_trigger_failures]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      pdt_event_log.extract_view_from_table: View Name
    series_column_widths:
      pdt_event_log.model_name: 200
      pdt_event_log.view_name: 275
      pdt_event_log.pdt_create_failures: 300
      pdt_event_log.pdt_trigger_failures: 210
      pdt_event_log.action: 200
      pdt_event_log.action_data: 150
      pdt_event_log.connection: 150
    series_cell_visualizations:
      pdt_event_log.pdt_create_failures:
        is_active: true
      pdt_event_log.pdt_trigger_failures:
        is_active: false
    series_text_format:
      pdt_event_log.pdt_trigger_failures:
        align: left
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 1e4d66b9-f066-4c33-b0b7-cc10b4810688, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: true, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_types: {}
    listen: {}
    row: 21
    col: 0
    width: 24
    height: 7
  - title: Errors by Query Source
    name: Errors by Query Source
    model: system__activity
    explore: history
    type: looker_bar
    fields: [history.query_run_count, history.source, history.created_date]
    pivots: [history.source]
    fill_fields: [history.created_date]
    filters:
      history.is_single_query: 'Yes'
      history.status: error
      history.created_date: 10 days
      history.workspace_id: "-dev"
    sorts: [history.source 0, history.created_date]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: right
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Errors, orientation: bottom, series: [{axisId: API 3 - history.query_run_count,
            id: API 3 - history.query_run_count, name: API 3}, {axisId: CSV Dashboard
              Download - history.query_run_count, id: CSV Dashboard Download - history.query_run_count,
            name: CSV Dashboard Download}, {axisId: Dashboard - history.query_run_count,
            id: Dashboard - history.query_run_count, name: Dashboard}, {axisId: Dashboard
              Prefetch - history.query_run_count, id: Dashboard Prefetch - history.query_run_count,
            name: Dashboard Prefetch}, {axisId: Drill Modal - history.query_run_count,
            id: Drill Modal - history.query_run_count, name: Drill Modal}, {axisId: Explore
              - history.query_run_count, id: Explore - history.query_run_count, name: Explore},
          {axisId: Merge Query - history.query_run_count, id: Merge Query - history.query_run_count,
            name: Merge Query}, {axisId: Other - history.query_run_count, id: Other
              - history.query_run_count, name: Other}, {axisId: PDT Regenerator -
              history.query_run_count, id: PDT Regenerator - history.query_run_count,
            name: PDT Regenerator}, {axisId: Private Embed - history.query_run_count,
            id: Private Embed - history.query_run_count, name: Private Embed}, {axisId: Public
              Embed - history.query_run_count, id: Public Embed - history.query_run_count,
            name: Public Embed}, {axisId: Query - history.query_run_count, id: Query
              - history.query_run_count, name: Query}, {axisId: Renderer - history.query_run_count,
            id: Renderer - history.query_run_count, name: Renderer}, {axisId: Saved
              Look - history.query_run_count, id: Saved Look - history.query_run_count,
            name: Saved Look}, {axisId: Scheduled Task - history.query_run_count,
            id: Scheduled Task - history.query_run_count, name: Scheduled Task}, {
            axisId: SQL Runner - history.query_run_count, id: SQL Runner - history.query_run_count,
            name: SQL Runner}, {axisId: Suggest Filter - history.query_run_count,
            id: Suggest Filter - history.query_run_count, name: Suggest Filter}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    hidden_series: [API 3 - history.query_run_count, Dashboard Prefetch - history.query_run_count,
      Other - history.query_run_count, Private Embed - history.query_run_count, Public
        Embed - history.query_run_count, Query - history.query_run_count, Renderer
        - history.query_run_count, SQL Runner - history.query_run_count, Suggest Filter
        - history.query_run_count]
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    series_types: {}
    series_colors: {}
    defaults_version: 1
    listen: {}
    row: 28
    col: 0
    width: 24
    height: 9
