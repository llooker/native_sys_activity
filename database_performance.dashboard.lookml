- dashboard: database_performance
  title: Database Performance
  layout: newspaper
  elements:
  - name: Performance Details (Last 7 Days)
    type: text
    title_text: Performance Details (Last 7 Days)
    subtitle_text: Identify and optimize underperforming content
    row: 52
    col: 0
    width: 24
    height: 2
  - name: PDT Overview (Last 7 Days)
    type: text
    title_text: PDT Overview (Last 7 Days)
    subtitle_text: Identify unsuccessful and slow building PDTs
    row: 60
    col: 0
    width: 24
    height: 2
  - title: Explore Performance
    name: Explore Performance
    model: system__activity
    explore: history
    type: looker_grid
    fields: [query.view, query.model, history.average_runtime]
    filters:
      query.view: "-NULL"
      history.created_date: 7 days
    sorts: [history.average_runtime desc]
    limit: 500
    column_limit: 50
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: false
    series_cell_visualizations:
      history.average_runtime:
        is_active: true
        palette:
          palette_id: c66d6394-1b71-9037-8af4-a8afad3d3679
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - yellow
          - orange
          - red
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: less than, value: 10, background_color: !!null '',
        font_color: green, palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}, {type: between, value: [10, 60], background_color: !!null '',
        font_color: orange, palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}, {type: greater than, value: 60, background_color: !!null '',
        font_color: red, palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format: {}
    hide_totals: false
    hide_row_totals: false
    truncate_column_names: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 54
    col: 0
    width: 8
    height: 6
  - title: Look Performance
    name: Look Performance
    model: system__activity
    explore: history
    type: looker_grid
    fields: [history.average_runtime, look.title]
    filters:
      look.id: NOT NULL
      history.created_date: 7 days
    sorts: [history.average_runtime desc]
    limit: 50
    column_limit: 50
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      look.title: Look Title
    series_cell_visualizations:
      history.average_runtime:
        is_active: true
        palette:
          palette_id: 2da7cc47-3bbe-4a65-3fd6-f853c6c96385
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - yellow
          - orange
          - red
        value_display: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: greater than, value: 60, background_color: !!null '',
        font_color: red, palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}, {type: between, value: [10, 60], background_color: !!null '',
        font_color: orange, palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}, {type: less than, value: 10, background_color: !!null '',
        font_color: green, palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format:
      history.average_runtime:
        name: decimal_2
        format_string: "#,##0.00"
        label: Decimals (2)
    hide_totals: false
    hide_row_totals: false
    truncate_column_names: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 54
    col: 8
    width: 8
    height: 6
  - title: Dashboard Performance
    name: Dashboard Performance
    model: system__activity
    explore: history
    type: looker_grid
    fields: [dashboard.title, query.count]
    filters:
      history.is_single_query: 'Yes'
      history.real_dash_id: "-NULL"
      history.created_date: 7 days
      history.status: complete
      history.runtime: ">30"
    sorts: [query.count desc]
    limit: 50
    column_limit: 50
    dynamic_fields: [{table_calculation: total_runtime, label: Total Runtime, expression: "${history.total_runtime}",
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    series_labels:
      query.count: Distinct Queries Over 30s
      dashboard.title: Dashboard Title
    series_cell_visualizations:
      query.count:
        is_active: true
        palette:
          palette_id: 73d1ef93-b985-1b44-34cd-fbfdcb055c8c
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - Yellow
          - Orange
          - Red
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 54
    col: 16
    width: 8
    height: 6
  - name: Concurrency Timelines (Last 7 Days - UTC)
    type: text
    title_text: Concurrency Timelines (Last 7 Days - UTC)
    subtitle_text: Spread automation across off peak concurrency hours to enhance
      performance
    body_text: ''
    row: 17
    col: 0
    width: 24
    height: 2
  - title: PDT Build Activity
    name: PDT Build Activity
    model: system__activity
    explore: pdt_event_log
    type: looker_grid
    fields: [pdt_event_log.view_name, pdt_event_log.connection, pdt_event_log.pdt_create_failures,
      pdt_event_log.pdt_trigger_failures, pdt_event_log.successful_pdt_builds]
    filters:
      pdt_event_log.view_name: "-NULL"
      pdt_event_log.created_date: 7 days
    sorts: [pdt_event_log.pdt_trigger_failures desc]
    limit: 500
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: 592616d0-58e4-4968-9030-928ef38b7b50
      palette_id: e7303a54-e53e-4cf0-abc9-2f175c1128e0
    column_order: [pdt_event_log.view_name, pdt_event_log.connection, pdt_event_log.percent_successful_builds,
      pdt_event_log.pdt_trigger_failures, pdt_event_log.pdt_create_failures, pdt_event_log.successful_pdt_builds]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      pdt_event_log.pdt_create_failures: Create Failures
      pdt_event_log.pdt_trigger_failures: Trigger Failures
      pdt_event_log.successful_pdt_builds: Successful Builds
    series_column_widths:
      pdt_event_log.view_name: 170
      pdt_event_log.connection: 170
      pdt_event_log.pdt_create_failures: 128
      pdt_event_log.pdt_trigger_failures: 170
      pdt_event_log.successful_pdt_builds: 183
      pdt_event_log.percent_successful_builds: 170
    series_cell_visualizations:
      pdt_event_log.pdt_create_failures:
        is_active: true
        palette:
          palette_id: e7a0cd98-8098-6e8b-19f2-e8fde8acdae3
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - yellow
          - orange
          - red
      pdt_event_log.successful_pdt_builds:
        is_active: true
      pdt_event_log.pdt_trigger_failures:
        is_active: true
        palette:
          palette_id: 93a687d7-f079-7a3d-8325-d7c1464e146a
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - yellow
          - orange
          - red
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: red, palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: [pdt_event_log.pdt_create_failures, pdt_event_log.pdt_trigger_failures]},
      {type: greater than, value: 0, background_color: !!null '', font_color: "#4FBC89",
        palette: {name: Red to Yellow to Green, colors: ["#F36254", "#FCF758", "#4FBC89"]},
        bold: false, italic: false, strikethrough: false, fields: [pdt_event_log.successful_pdt_builds]},
      {type: along a scale..., value: !!null '', background_color: "#3EB0D5", font_color: !!null '',
        color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7, custom: {
            id: bea390f0-e01a-28a5-7748-aa53baeba45b, label: Custom, type: continuous,
            stops: [{color: "#4FBC89", offset: 0}, {color: "#FCF758", offset: 50},
              {color: "#F36254", offset: 100}]}, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0.999}, max: {type: maximum}},
            mirror: false, reverse: true, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    truncate_column_names: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 62
    col: 0
    width: 12
    height: 6
  - title: PDT Average Build Time
    name: PDT Average Build Time
    model: system__activity
    explore: pdt_builds
    type: looker_grid
    fields: [pdt_builds.view_name, pdt_builds.connection, pdt_builds.model_name, pdt_builds.average_build_time_minutes]
    sorts: [pdt_builds.average_build_time_minutes desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    series_labels:
      pdt_builds.average_build_time_seconds: Avg Build Seconds
      pdt_builds.average_build_time_minutes: Avg Build Minutes
    series_cell_visualizations:
      pdt_builds.average_build_time_minutes:
        is_active: true
        palette:
          palette_id: 175d5ab4-cb7c-69cc-970a-5ef98d345ba2
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - yellow
          - orange
          - red
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 62
    col: 12
    width: 12
    height: 6
  - title: Hourly PDT Builds by Connection
    name: Hourly PDT Builds by Connection
    model: system__activity
    explore: pdt_event_log
    type: looker_area
    fields: [pdt_event_log.count, pdt_event_log.connection, pdt_event_log.created_hour_of_day]
    pivots: [pdt_event_log.connection]
    fill_fields: [pdt_event_log.created_hour_of_day]
    filters:
      pdt_event_log.action: create begin
      pdt_event_log.created_date: 7 days
    sorts: [pdt_event_log.connection, pdt_event_log.created_hour_of_day]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axes: [{label: '', orientation: left, series: [{axisId: pdt_event_log.count,
            id: finance_spoke - pdt_event_log.count, name: finance_spoke}, {axisId: pdt_event_log.count,
            id: looker_application - pdt_event_log.count, name: looker_application},
          {axisId: pdt_event_log.count, id: looker-internal - pdt_event_log.count,
            name: looker-internal}, {axisId: pdt_event_log.count, id: looker-internal-secure
              - pdt_event_log.count, name: looker-internal-secure}, {axisId: pdt_event_log.count,
            id: meta - pdt_event_log.count, name: meta}, {axisId: pdt_event_log.count,
            id: sales-app-bq - pdt_event_log.count, name: sales-app-bq}, {axisId: pdt_event_log.count,
            id: xactly-spoke - pdt_event_log.count, name: xactly-spoke}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Created Hour of Day - UTC
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: asc
    show_null_labels: false
    note_state: collapsed
    note_display: hover
    note_text: ''
    hidden_fields: []
    listen: {}
    row: 31
    col: 0
    width: 24
    height: 6
  - title: Hourly Schedules
    name: Hourly Schedules
    model: system__activity
    explore: scheduled_plan
    type: looker_column
    fields: [scheduled_job.count, scheduled_job.created_hour_of_day, scheduled_plan.count]
    fill_fields: [scheduled_job.created_hour_of_day]
    filters:
      scheduled_job.created_date: 7 days
    sorts: [scheduled_job.created_hour_of_day]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axes: [{label: '', orientation: left, series: [{id: scheduled_job.count, name: Scheduled
              Job Count, axisId: scheduled_job.count}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [{id: scheduled_plan.count, name: Scheduled
              Plan Count, axisId: scheduled_plan.count}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Hour of Day
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    series_types: {}
    point_style: none
    series_colors: {}
    series_labels: {}
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    note_state: collapsed
    note_display: below
    note_text: Total schedule counts over the last 7 days for each hour of the day.
      The scheduled plan count is the number of unique schedules set to send that
      hour. One scheduled plan can run multiple times per hour and the scheduled job
      count is the cumulative number of scheduled jobs run per hour.
    hidden_fields: []
    listen: {}
    row: 25
    col: 0
    width: 24
    height: 6
  - title: Hourly Users & Queries
    name: Hourly Users & Queries
    model: system__activity
    explore: history
    type: looker_column
    fields: [history.created_hour_of_day, history.query_run_count, user.count, history.cache_result_query_count]
    fill_fields: [history.created_hour_of_day]
    filters:
      history.is_single_query: 'Yes'
      history.created_date: 7 days
    sorts: [history.created_hour_of_day]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: from_cache, label: "% From Cache", expression: "${history.cache_result_query_count}\
          \ / ${history.query_run_count}", value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: user.count, name: User Count,
            axisId: user.count}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}, {label: !!null '', orientation: right,
        series: [{id: history.query_run_count, name: History Query Run Count, axisId: history.query_run_count}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {id: from_cache, name: "% From Cache", axisId: from_cache}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Created Hour of Day - UTC
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hidden_series: [history.query_run_count]
    legend_position: center
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    series_types:
      from_cache: line
      user.count: area
    point_style: none
    series_colors: {}
    series_labels:
      user.count: User Count
      from_cache: "% Queries From Cache"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [history.cache_result_query_count]
    listen: {}
    row: 19
    col: 0
    width: 24
    height: 6
  - title: Query Runtimes by Issuer Source (Last 30 Days)
    name: Query Runtimes by Issuer Source (Last 30 Days)
    model: system__activity
    explore: history
    type: looker_donut_multiples
    fields: [history.issuer_source, history.query_run_count, history.runtime_tiers]
    pivots: [history.runtime_tiers]
    filters:
      history.is_single_query: 'Yes'
      history.runtime_tiers: "-Undefined,-Below 0"
      history.issuer_source: "-Other"
      history.completed_date: 30 days
    sorts: [history.issuer_source desc, history.runtime_tiers 0]
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 12
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    series_colors:
      0 to 4 - 1 - history.query_run_count: "#75E2E2"
      5 to 9 - 2 - history.query_run_count: "#72D16D"
      10 to 29 - 3 - history.query_run_count: "#C2DD67"
      30 to 119 - 4 - history.query_run_count: "#FFD95F"
      120 to 299 - 5 - history.query_run_count: "#E57947"
      300 or Above - 6 - history.query_run_count: "#B32F37"
    series_labels:
      0 to 4 - 1 - history.query_run_count: 0 to 4s
      5 to 9 - 2 - history.query_run_count: 5 to 9s
      10 to 29 - 3 - history.query_run_count: 10 to 29s
      30 to 119 - 4 - history.query_run_count: 30 to 119s
      120 to 299 - 5 - history.query_run_count: 120 to 299s
      300 or Above - 6 - history.query_run_count: 300s or Above
    value_labels: legend
    label_type: per
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    note_state: collapsed
    note_display: below
    note_text: |-
      Click here to expand source details...

      User Sources: dashboards, drill downs, explores, looks, private/public embeds,  sql_runner, suggest_filters, merge_queries, renderer.

      System Sources: scheduled_tasks, pdt_regenerator.

      API sources: API 3.0, dashboard_prefetch, data_download_api
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 0
    col: 7
    width: 17
    height: 6
  - title: Top 15 Users by Query Count (last 7 days)
    name: Top 15 Users by Query Count (last 7 days)
    model: system__activity
    explore: history
    type: looker_grid
    fields: [history.query_run_count, history.created_day_of_week, user_query_rank.user_name]
    pivots: [user_query_rank.user_name]
    fill_fields: [history.created_day_of_week]
    filters:
      history.created_date: 7 days
    sorts: [history.created_day_of_week, user_query_rank.user_name desc]
    limit: 500
    column_limit: 15
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    series_labels:
      history.created_day_of_week: Created
      zz_user_query_rank.user_query_rank: Rank
      user_query_rank.user_query_rank: Rank
    series_column_widths:
      history.created_day_of_week: 83
    series_cell_visualizations:
      history.query_run_count:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null '', color_application: {collection_id: legacy, custom: {id: 85ebde76-7c6b-6970-071e-79fda2ac49b3,
            label: Custom, type: continuous, stops: [{color: "#F36254", offset: 0},
              {color: "#FCF758", offset: 50}, {color: "#4FBC89", offset: 100}]}, options: {
            steps: 5, reverse: true}}}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    subtotals_at_bottom: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 6
    col: 0
    width: 24
    height: 6
  - title: Results from Cache
    name: Results from Cache
    model: system__activity
    explore: history
    type: single_value
    fields: [history.query_run_count, history.cache_result_query_count, history.created_date]
    fill_fields: [history.created_date]
    filters:
      history.is_single_query: 'Yes'
      history.created_date: 60 days
    sorts: [history.created_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: from_cache_last_30, label: "% From Cache\
          \ last 30", expression: 'sum(if(row() < 30, ${history.cache_result_query_count},
          0)) / sum(if(row() < 30, ${history.query_run_count}, 0))', value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}, {
        table_calculation: prior_30, label: "% Prior 30", expression: 'sum(if(row()
          > 30 AND row() <= 60, ${history.cache_result_query_count}, 0)) / sum(if(row()
          > 30 AND row() <= 60, ${history.query_run_count}, 0))', value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number}, {
        table_calculation: from_last_period, label: From Last Period, expression: "${from_cache_last_30}\
          \ - ${prior_30}", value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    series_types: {}
    hidden_fields: [history.query_run_count, history.created_date, history.cache_result_query_count,
      prior_30]
    note_state: collapsed
    note_display: hover
    note_text: Percentage of total queries returned from Looker cache.
    listen: {}
    row: 0
    col: 0
    width: 7
    height: 6
  - title: Top 10 Sources by Query Count (last 7 days)
    name: Top 10 Sources by Query Count (last 7 days)
    model: system__activity
    explore: history
    type: looker_grid
    fields: [history.query_run_count, history.created_day_of_week, source_query_rank.sorted_source]
    pivots: [source_query_rank.sorted_source]
    fill_fields: [history.created_day_of_week]
    filters:
      history.created_date: 7 days
    sorts: [history.created_day_of_week, source_query_rank.sorted_source desc]
    limit: 500
    column_limit: 50
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    size_to_fit: true
    series_labels:
      zz_source_rank.source_rank: Rank
      zz_source_query_rank.source_query_rank: Rank
      history.source: Source
      history.created_day_of_week: Created
      source_query_rank.source_query_rank: Rank
    series_column_widths:
      history.created_day_of_week: 85
    series_cell_visualizations:
      history.query_run_count:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false,
        fields: !!null '', color_application: {collection_id: legacy, custom: {id: 95f8f710-092a-a7e2-9207-021d209d7377,
            label: Custom, type: continuous, stops: [{color: "#F36254", offset: 0},
              {color: "#FCF758", offset: 50}, {color: "#4FBC89", offset: 100}]}, options: {
            steps: 5, reverse: true, stepped: false}}}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    truncate_column_names: true
    subtotals_at_bottom: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen: {}
    row: 12
    col: 0
    width: 24
    height: 5
