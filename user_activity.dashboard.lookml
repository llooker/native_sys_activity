- dashboard: user_activity
  title: User Activity
  layout: newspaper
  elements:
  - name: User Accounts & Adoption
    type: text
    title_text: User Accounts & Adoption
    subtitle_text: ''
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - name: About Your Users
    type: text
    title_text: About Your Users
    row: 22
    col: 0
    width: 24
    height: 2
  - title: Querying (Last 7 Days)
    name: Querying (Last 7 Days)
    model: system__activity
    explore: user
    type: single_value
    fields: [user.count, filtered_history_users_last_7days.users_7_days]
    sorts: [user.count desc]
    limit: 500
    dynamic_fields: [{table_calculation: percent_active, label: Percent Active, expression: "${filtered_history_users_last_7days.users_7_days}\
          \ / ${user.count}", value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      history.active_user: "#ba2044"
      user.count: "#3e56a8"
      total_users: "#3e56a8"
      percent_active: "#ba2044"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: !!null '', orientation: left, series: [{id: total_users, name: Total
              Users, axisId: total_users}], showLabels: true, showValues: true, maxValue: !!null '',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [{id: percent_active, name: Percent
              Active, axisId: percent_active}], showLabels: true, showValues: true,
        maxValue: 1, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [total_users, user.count, history.active_user, filtered_history_users_last_7days.users_7_days]
    note_state: expanded
    note_display: hover
    note_text: Active percentage of "Total Users"
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 2
    col: 20
    width: 4
    height: 4
  - title: Weekly Querying Users
    name: Weekly Querying Users
    model: system__activity
    explore: history
    type: looker_area
    fields: [user.count, history.completed_week]
    fill_fields: [history.completed_week]
    filters:
      history.completed_week: 6 weeks ago for 6 weeks
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#B32F37", label: 'Avg: {{mean}}', value_format: 0.#}]
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    note_state: collapsed
    note_display: above
    note_text: Keep a pulse on general user activity
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 6
    col: 0
    width: 12
    height: 7
  - title: Weekly Engagement per User
    name: Weekly Engagement per User
    model: system__activity
    explore: history
    type: looker_line
    fields: [history.approximate_usage_in_minutes, history.query_run_count, user.count,
      history.completed_week]
    fill_fields: [history.completed_week]
    filters:
      user.is_disabled: 'No'
      history.is_single_query: 'Yes'
      history.completed_week: 6 weeks ago for 6 weeks
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: avg_minutes_per_user, label: Avg Minutes
          per User, expression: "${history.approximate_usage_in_minutes} / ${user.count}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: avg_queries_per_user, label: Avg
          Queries per User, expression: "${history.query_run_count} / ${user.count}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}]
    stacking: ''
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_labels: {}
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: avg_minutes_per_user, name: Avg
              Minutes per User, axisId: avg_minutes_per_user}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{id: avg_queries_per_user,
            name: Avg Queries per User, axisId: avg_queries_per_user}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: []
    show_null_points: true
    interpolation: linear
    hidden_fields: [user.count, history.approximate_usage_in_minutes, history.query_run_count]
    note_state: collapsed
    note_display: above
    note_text: Understand lifts and dips in average usage trends
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 6
    col: 12
    width: 12
    height: 7
  - title: User Count by Query Source
    name: User Count by Query Source
    model: system__activity
    explore: history
    type: looker_line
    fields: [user.count, history.source, history.completed_date]
    pivots: [history.source]
    fill_fields: [history.completed_date]
    filters:
      history.source: "-Dashboard Prefetch,-Scheduled Task"
      history.completed_date: 7 days ago for 7 days
    sorts: [user.count desc 0, history.source]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ["#75E2E2", "#3EB0D5", "#4276BE", "#462C9D", "#9174F0", "#B1399E", "#B32F37",
      "#E57947", "#FBB555", "#FFD95F", "#C2DD67", "#72D16D"]
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    hidden_series: [API 3 - user.count, Dashboard Prefetch - user.count, Other - user.count,
      Private Embed - user.count, Public Embed - user.count, Query - user.count, Renderer
        - user.count, Scheduled Task - user.count, SQL Runner - user.count, Suggest
        Filter - user.count]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    note_state: collapsed
    note_display: below
    note_text: |-
      Click here to expand source info...
      API - queries that came from the Looker API for the instance
      Dashboard - queries relating to tiles present on a Dashboard run
      Explore - queries associated with running Explores
      Other - data-download-api, drill_modal, merge_query, regenerator, source_query
      Private Embed - queries that are initiated by a private embed context
      Public Embed - queries ran from content accessed via public url
      Renderer - queries relating to the generation of images (.png and .pdf) for scheduled items and downloads.
      SQL Runner - queries are run directly in the SQL Runner
      Saved Look - queries associated with Looks
      Scheduled Task - queries that are run by Looker when it generates a Look/Dashboard to send out
      Suggest Filter - queries when users click on a filter that gives suggestions
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 13
    col: 0
    width: 24
    height: 9
  - title: Top Users
    name: Top Users
    model: system__activity
    explore: history
    type: table
    fields: [user.name, history.approximate_usage_in_minutes, history.query_run_count]
    filters:
      history.is_single_query: 'Yes'
      history.completed_date: 7 days
    sorts: [history.approximate_usage_in_minutes desc]
    limit: 10
    dynamic_fields: [{table_calculation: percent_under_10s, label: Percent Under 10s,
        expression: "${history.queries_under_10s} / ${history.query_run_count}", value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, _type_hint: number, is_disabled: true}]
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      user.name: Name
      history.approximate_usage_in_minutes: Minutes
      history.query_run_count: Queries
      percent_under_10s: "% Queries Under 10s"
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Top users by approximate minutes used and query count in the last 7
      days.
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 24
    col: 0
    width: 8
    height: 6
  - title: Top Developers
    name: Top Developers
    model: system__activity
    explore: event_attribute
    type: table
    fields: [event.count, user.name]
    filters:
      event.category: git
      user.name: "-NULL"
    sorts: [event.count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      event.count: Git Events
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Users with the most "git" category events. (The time frame for this
      Look comes from the system_activity events table, and therefore varies in how
      far back data is stored)
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 24
    col: 16
    width: 8
    height: 6
  - title: Top Dashboard Builders
    name: Top Dashboard Builders
    model: system__activity
    explore: dashboard
    type: table
    fields: [user.name, dashboard.count, dashboard_element.count]
    filters:
      user.name: "-NULL"
      user.is_disabled: 'No'
    sorts: [dashboard.count desc]
    limit: 500
    dynamic_fields: [{table_calculation: total_content, label: Total Content, expression: "${dashboard.count}\
          \ + ${dashboard_element.count} + ${look.count}", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number, is_disabled: true}]
    filter_expression: |
      diff_days(${dashboard.created_date}, now()) <= 7
      OR
      diff_days(${dashboard_element.created_date}, now()) <= 7
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      look.count: Dashboard Look Count
      user.name: Name
      dashboard_element.count: Dash. Elements
      dashboard.count: Dashboards
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    note_state: expanded
    note_display: hover
    note_text: Users with the most new dashboards and new dashboard elements in the
      last 7 days.
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 24
    col: 8
    width: 8
    height: 6
  - title: Total Users
    name: Total Users
    model: system__activity
    explore: user
    type: single_value
    fields: [user.count]
    filters:
      user.is_disabled: 'No'
      user_facts.is_viewer: 'Yes'
    limit: 500
    dynamic_fields: [{table_calculation: total_users, label: Total Users, expression: 'sum(${user.count})',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: looker_users,
        label: Looker Users, expression: 'coalesce(sum(if(${user_facts.is_looker_employee},
          ${user.count}, 0)), 0)', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number, is_disabled: true}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Looker Users
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Total named users (non-disabled).
    hidden_fields:
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 2
    col: 0
    width: 4
    height: 4
  - title: Data-Consumers
    name: Data-Consumers
    model: system__activity
    explore: user
    type: single_value
    fields: [user_facts.count]
    filters:
      user_facts.is_viewer: 'Yes'
      user_facts.is_developer: 'No'
      user_facts.is_admin: 'No'
      user_facts.is_embed: 'No'
      user.is_disabled: 'No'
      user_facts.is_content_saver: 'No'
      user_facts.is_explorer: 'No'
    sorts: [user_facts.count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    note_state: collapsed
    note_display: hover
    note_text: Total named users with "access data" permissions and not "admin", "developer",
      "explore" or "save content" permissions (non-disabled/non-embed).
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 2
    col: 12
    width: 4
    height: 4
  - title: Embed Content Creators
    name: Embed Content Creators
    model: system__activity
    explore: user
    type: single_value
    fields: [user.count]
    filters:
      user.is_disabled: 'No'
      user_facts.is_embed: 'Yes'
      user_facts.is_admin: 'No'
      user_facts.is_developer: 'No'
    limit: 500
    filter_expression: "(${user_facts.is_explorer} OR ${user_facts.is_content_saver})"
    query_timezone: America/Los_Angeles
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Total named embed users with "explore" or "save content" permissions
      and not "admin" or "developer" permissions (non-disabled).
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 2
    col: 16
    width: 4
    height: 2
  - title: Admin/Developers
    name: Admin/Developers
    model: system__activity
    explore: user
    type: single_value
    fields: [user.count]
    filters:
      user.is_disabled: 'No'
    sorts: [user.count desc]
    limit: 500
    filter_expression: "(${user_facts.is_admin} OR ${user_facts.is_developer})"
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Looker Users
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Total named users with "admin" or "developer" permissions (non-disabled/non-embed).
    hidden_fields:
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 2
    col: 4
    width: 4
    height: 4
  - title: Content Creators
    name: Content Creators
    model: system__activity
    explore: user
    type: single_value
    fields: [user_facts.count]
    filters:
      user.is_disabled: 'No'
      user_facts.is_admin: 'No'
      user_facts.is_developer: 'No'
      user_facts.is_embed: 'No'
    sorts: [user_facts.count desc]
    limit: 500
    column_limit: 50
    filter_expression: "(${user_facts.is_explorer} OR ${user_facts.is_content_saver})"
    query_timezone: America/Los_Angeles
    note_state: collapsed
    note_display: hover
    note_text: Total named users with "explore" or "save content" permissions and
      not "admin" or "developer" permissions (non-disabled/non-embed).
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 2
    col: 8
    width: 4
    height: 4
  - title: Embed Data-Consumers
    name: Embed Data-Consumers
    model: system__activity
    explore: user
    type: single_value
    fields: [user.count]
    filters:
      user_facts.is_embed: 'Yes'
      user.is_disabled: 'No'
      user_facts.is_viewer: 'Yes'
      user_facts.is_explorer: 'No'
      user_facts.is_content_saver: 'No'
      user_facts.is_admin: 'No'
      user_facts.is_developer: 'No'
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Total named embed users with "access data" permissions and not "admin",
      "develop", "explore" or "save content" permissions (non-disabled).
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 4
    col: 16
    width: 4
    height: 2
  - name: User Resources
    type: text
    title_text: User Resources
    subtitle_text: Education & Training
    body_text: |-
      **Basic:**

      + [Getting started with Looker](https://looker.com/guide/getting-started)
      + [Explorer Training](https://training.looker.com/looker-for-data-explorers)
      + [LookML Foundations](https://training.looker.com/looker-development-foundations)

      **Intermediate:**

      + [Dashboard Design](https://training.looker.com/designing-great-dashboards)
      + [Explore Building](https://training.looker.com/building-explores-users-will-love)

      **Advanced:**

      + [Developer Bootcamps](https://training.looker.com/series/classroom-training)
    row: 36
    col: 0
    width: 24
    height: 7
  - title: Unengaged Users
    name: Unengaged Users
    model: system__activity
    explore: user
    type: table
    fields: [user.id, user.name, user.created_date, user_facts.last_ui_login_date,
      history.most_recent_query_date, scheduled_plan.count, user_facts.last_ui_login_credential_type]
    filters:
      user_facts.last_ui_login_date: before 90 days ago
      user.is_disabled: 'No'
    sorts: [user_facts.last_ui_login_date]
    limit: 100
    column_limit: 50
    dynamic_fields: [{table_calculation: no_query_login, label: 'No-Query Login?',
        expression: "${history.most_recent_query_date} < ${user_facts.last_ui_login_date}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: yesno}, {table_calculation: days_since_last_login, label: Days
          Since Last Login, expression: 'diff_days(${user_facts.last_ui_login_date},
          trunc_days(now()))', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 592616d0-58e4-4968-9030-928ef38b7b50
      palette_id: e7303a54-e53e-4cf0-abc9-2f175c1128e0
    series_labels:
      user_facts.last_ui_login_date: Last Login
      user_facts.last_api_login_date: Last API Login Date
      user.name: Name
      user.created_date: Created Date
      history.most_recent_query_date: Last Query
      scheduled_plan.count: Count of Scheduled Plans
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1D98D3",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 721299c7-f114-43fc-926f-5bf0462bbfca, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: middle}, max: {type: maximum}}, reverse: true}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [user.id, no_query_login]
    note_state: collapsed
    note_display: hover
    note_text: Users who have not authenticated into Looker in the last 90 days.
    defaults_version: 1
    listen:
      Is Looker Employee: user_facts.is_looker_employee
    row: 30
    col: 0
    width: 24
    height: 6
  filters:
  - name: Is Looker Employee
    title: Is Looker Employee
    type: field_filter
    default_value: 'No'
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: system__activity
    explore: user
    listens_to_filters: []
    field: user_facts.is_looker_employee
