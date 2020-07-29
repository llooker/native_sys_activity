- dashboard: content_activity
  title: Content Activity
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: Explores
    name: Explores
    model: system__activity
    explore: history
    type: single_value
    fields: [query.first_query_at, query.view]
    filters:
      query.view: "-NULL"
      history.created_date: 30 days
    sorts: [query.first_query_at]
    limit: 1500
    dynamic_fields: [{table_calculation: first_query_date, label: First Query Date,
        expression: "date(\n  to_number(substring(${query.first_query_at}, 0, 4)),\n\
          \  to_number(substring(${query.first_query_at}, 6, 2)),\n  to_number(substring(${query.first_query_at},\
          \ 9, 2))\n)", value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: date}, {table_calculation: total_explores, label: Total Explores,
        expression: 'count(${query.view}) + (0 * ${last_30_days})', value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}, {
        table_calculation: last_30_days, label: Last 30 Days, expression: "sum(\n\
          \  if(diff_days(${first_query_date}, now()) <= 30, 1, 0)\n)", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Explores Used Last 30 Days
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Created Last 30 Days
    hidden_fields: [query.first_query_at, first_query_date, query.view]
    series_types: {}
    listen: {}
    row: 13
    col: 0
    width: 24
    height: 3
  - title: Total Dashboards
    name: Total Dashboards
    model: system__activity
    explore: dashboard
    type: single_value
    fields: [dashboard.count, dashboard.count_last_30_days]
    filters:
      dashboard.deleted_date: 'NULL'
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: total_dashboards, label: Total Dashboards,
        expression: 'sum(${dashboard.count})', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number, is_disabled: true}, {table_calculation: last_30_days,
        label: Last 30 days, expression: "sum(\n  if(diff_days(${dashboard.created_date},\
          \ now()) <= 30, ${dashboard.count},0))", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number, is_disabled: true}, {measure: in_last_30_days,
        based_on: dashboard.id, type: count_distinct, label: In Last 30 Days, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number, filter_expression: 'diff_days(${dashboard.created_date},
          now()) <= 30'}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: ''
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Last 30 Days
    series_types: {}
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: Total Non-Deleted Dashboards
    listen: {}
    row: 2
    col: 0
    width: 8
    height: 3
  - title: Top Explores
    name: Top Explores
    model: system__activity
    explore: history
    type: looker_grid
    fields: [query.view, history.query_run_count, user.count, query.model]
    filters:
      history.created_date: 30 days
      history.source: Explore
    sorts: [history.query_run_count desc]
    limit: 15
    query_timezone: America/Los_Angeles
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      user.count: User Count
    series_cell_visualizations:
      history.query_run_count:
        is_active: true
      user.count:
        is_active: true
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
    listen: {}
    row: 18
    col: 12
    width: 12
    height: 8
  - name: Content Usage
    type: text
    title_text: Content Usage
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Total Looks
    name: Total Looks
    model: system__activity
    explore: look
    type: single_value
    fields: [look.count, look.count_last_30_days]
    filters:
      look.deleted_date: 'NULL'
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Last 30 Days
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: Total Non-Deleted Looks
    listen: {}
    row: 2
    col: 8
    width: 8
    height: 3
  - name: Explore Building Resources
    type: text
    title_text: Explore Building Resources
    body_text: + [Explore "Best Practices"](https://help.looker.com/hc/en-us/articles/360001766908-Best-Practice-Create-a-Positive-Experience-for-Looker-Users)
    row: 36
    col: 0
    width: 24
    height: 3
  - name: Explore Usage
    type: text
    title_text: Explore Usage
    row: 11
    col: 0
    width: 24
    height: 2
  - title: Popular Content
    name: Popular Content
    model: system__activity
    explore: content_usage
    type: looker_grid
    fields: [content_usage.content_id, content_usage.content_title, content_usage.content_type,
      content_usage.other_total, content_usage.favorites_total, content_usage.schedule_total,
      content_usage.embed_total, content_usage.api_total]
    filters:
      content_usage.days_since_last_accessed: "<30"
    sorts: [content_usage.other_total desc]
    limit: 50
    query_timezone: America/Los_Angeles
    column_order: ["$$$_row_numbers_$$$", content_usage.content_title, content_usage.content_type,
      content_usage.other_total, content_usage.embed_total, content_usage.api_total,
      content_usage.favorites_total, content_usage.schedule_total]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_cell_visualizations:
      content_usage.embed_total:
        is_active: false
      content_usage.other_total:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: [
          content_usage.other_total]}, {type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: [
          content_usage.schedule_total]}, {type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: [
          content_usage.favorites_total]}, {type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: [
          content_usage.api_total]}, {type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: [
          content_usage.embed_total]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [content_usage.content_id]
    note_state: collapsed
    note_display: hover
    note_text: All time counts for content that have been accessed within the last
      30 days.
    series_types: {}
    listen: {}
    row: 18
    col: 0
    width: 12
    height: 8
  - title: Daily Scheduled Jobs
    name: Daily Scheduled Jobs
    model: system__activity
    explore: scheduled_plan
    type: looker_pie
    fields: [scheduled_job.created_day_of_week, scheduled_job.count]
    fill_fields: [scheduled_job.created_day_of_week]
    filters:
      scheduled_plan.run_once: 'No'
      scheduled_job.created_date: 7 days ago for 7 days
    sorts: [scheduled_job.created_day_of_week]
    limit: 500
    query_timezone: America/Los_Angeles
    value_labels: legend
    label_type: lab
    inner_radius: 50
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    series_colors: {}
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Last 30 Days
    hidden_fields:
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Number of scheduled jobs each day for last 7 days. One scheduled plan
      may have multiple scheduled jobs.
    listen: {}
    row: 5
    col: 16
    width: 8
    height: 6
  - title: Dashboards Usage
    name: Dashboards Usage
    model: system__activity
    explore: dashboard
    type: looker_donut_multiples
    fields: [dashboard.count, filtered_history_dashboards.dashboards_used_last_30]
    filters:
      dashboard.deleted_date: 'NULL'
    sorts: [dashboard.count desc]
    limit: 500
    dynamic_fields: [{table_calculation: used_dashboards, label: Used Dashboards,
        expression: "${filtered_history_dashboards.dashboards_used_last_30}", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number, is_disabled: true},
      {table_calculation: unused_dashboards, label: Unused Dashboards, expression: "${dashboard.count}\
          \ - ${filtered_history_dashboards.dashboards_used_last_30}", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_value_labels: true
    font_size: 12
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    series_colors: {}
    series_labels:
      filtered_history_dashboards.dashboards_used_last_30: Used Dashboards
    series_types: {}
    hidden_fields: [dashboard.count, filtered_history_dashboards.active_dashboards]
    note_state: collapsed
    note_display: hover
    note_text: '"Used" Dashboards were queried in the last 30 days'
    listen: {}
    row: 5
    col: 0
    width: 8
    height: 6
  - name: Popular Content and Explores
    type: text
    title_text: Popular Content and Explores
    row: 16
    col: 0
    width: 24
    height: 2
  - name: Unused Content and Explores
    type: text
    title_text: Unused Content and Explores
    subtitle_text: Remove unused content on the <a href="/browse/unused">Unused Content
      page</a>
    row: 26
    col: 0
    width: 24
    height: 2
  - title: Looks Usage
    name: Looks Usage
    model: system__activity
    explore: look
    type: looker_donut_multiples
    fields: [look.count, filtered_history_looks.looks_used_last_30]
    filters:
      look.deleted_date: 'NULL'
    sorts: [look.count desc]
    limit: 500
    dynamic_fields: [{table_calculation: used_looks, label: Used Looks, expression: "${filtered_history_looks.looks_used_last_30}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: unused_looks,
        label: Unused Looks, expression: "${look.count} - ${filtered_history_looks.looks_used_last_30}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_value_labels: true
    font_size: 12
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    series_colors: {}
    series_labels:
      filtered_history_looks.looks_used_last_30: Used Looks
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Active Looks
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Total Looks
    series_types: {}
    hidden_fields: [look.count, filtered_history_looks.active_looks]
    note_state: collapsed
    note_display: hover
    note_text: '"Used" Looks were queried AS LOOKS (meaning not queried within Dashboards)
      in the last 30 days'
    listen: {}
    row: 5
    col: 8
    width: 8
    height: 6
  - title: Unused Explores
    name: Unused Explores
    model: system__activity
    explore: history
    type: looker_grid
    fields: [query.view, query.model, query.first_query_at, history.query_run_count,
      history.most_recent_query_date]
    filters:
      query.view: "-NULL"
      history.most_recent_query_date: before 30 days ago
    sorts: [history.most_recent_query_date]
    limit: 100
    dynamic_fields: [{table_calculation: first_query_date, label: First Query Date,
        expression: 'substring(${query.first_query_at},0,10)', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: string}, {
        table_calculation: days_since_last_query, label: Days Since Last Query, expression: 'diff_days(${history.most_recent_query_date},
          now())', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    column_order: ["$$$_row_numbers_$$$", query.view, query.model, days_since_last_query,
      history.query_run_count, history.most_recent_query_date, first_query_date]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      history.most_recent_query_date: Last Query
      first_query_date: First Query
      history.query_run_count: Query Run Count
    series_column_widths:
      query.view: 200
      query.model: 150
      days_since_last_query: 150
    series_cell_visualizations:
      history.query_run_count:
        is_active: true
      days_since_last_query:
        is_active: true
        palette:
          palette_id: 86f8cdb6-9647-deba-106c-ba013817617c
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - "#4FBC89"
          - "#FCF758"
          - "#F36254"
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
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: Total Queried
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [query.first_query_at]
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Explores used in the last 90 days that have not been queried in the
      last 30 days.
    listen: {}
    row: 28
    col: 12
    width: 12
    height: 8
  - title: Scheduled Plans
    name: Scheduled Plans
    model: system__activity
    explore: scheduled_plan
    type: single_value
    fields: [scheduled_plan.count, scheduled_plan.count_last_30_days]
    filters:
      scheduled_plan.run_once: 'No'
      scheduled_plan.enabled: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Last 30 Days
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: Excludes "Send Once" Schedules.
    listen: {}
    row: 2
    col: 16
    width: 8
    height: 3
  - title: Unused Content
    name: Unused Content
    model: system__activity
    explore: content_usage
    type: looker_grid
    fields: [content_usage.content_id, dashboard.created_date, look.created_date,
      content_usage.content_title, content_usage.content_type, content_usage.embed_total,
      content_usage.api_total, content_usage.favorites_total, content_usage.schedule_total,
      content_usage.other_total]
    filters:
      content_usage.days_since_last_accessed: ">30"
      _dashboard_linked_looks.is_used_on_dashboard: 'No'
    sorts: [content_usage.other_total]
    limit: 100
    dynamic_fields: [{table_calculation: created_date, label: Created Date, expression: 'concat(coalesce(to_string(${dashboard.created_date}),
          ""), coalesce(to_string(${look.created_date}), ""))', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, _type_hint: string}]
    filter_expression: "if(is_null(${dashboard.deleted_date}) = no \n     OR is_null(${look.deleted_date})\
      \ = no \n  , no\n  , yes\n)\n"
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_totals: true
    show_row_totals: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: [
          content_usage.other_total], color_application: {collection_id: legacy, palette_id: legacy_sequential1,
          options: {steps: 5, reverse: false}}}, {type: along a scale..., value: !!null '',
        background_color: !!null '', font_color: !!null '', palette: {name: White
            to Green, colors: ["#FFFFFF", "#4FBC89"]}, bold: false, italic: false,
        strikethrough: false, fields: [content_usage.schedule_total], color_application: {
          collection_id: legacy, palette_id: legacy_sequential1, options: {steps: 5,
            reverse: false}}}, {type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: White to Green, colors: ["#FFFFFF",
            "#4FBC89"]}, bold: false, italic: false, strikethrough: false, fields: [
          content_usage.favorites_total], color_application: {collection_id: legacy,
          palette_id: legacy_sequential1, options: {steps: 5}}}, {type: along a scale...,
        value: !!null '', background_color: !!null '', font_color: !!null '', palette: {
          name: White to Green, colors: ["#FFFFFF", "#4FBC89"]}, bold: false, italic: false,
        strikethrough: false, fields: [content_usage.api_total], color_application: {
          collection_id: legacy, palette_id: legacy_sequential1, options: {steps: 5}}},
      {type: along a scale..., value: !!null '', background_color: !!null '', font_color: !!null '',
        palette: {name: White to Green, colors: ["#FFFFFF", "#4FBC89"]}, bold: false,
        italic: false, strikethrough: false, fields: [content_usage.embed_total],
        color_application: {collection_id: legacy, palette_id: legacy_sequential1,
          options: {steps: 5}}}]
    truncate_column_names: false
    hidden_fields: [dashboard.created_date, look.created_date, content_usage.content_id]
    note_state: collapsed
    note_display: hover
    note_text: All time counts for content that have NOT been accessed within the
      last 30 days.
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 28
    col: 0
    width: 12
    height: 8
