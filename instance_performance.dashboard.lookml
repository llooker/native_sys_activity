- dashboard: instance_performance
  title: Instance Performance
  layout: newspaper
  elements:
  - name: Optimization Resources
    type: text
    title_text: Optimization Resources
    body_text: "+ [Looker Optimization](https://help.looker.com/hc/en-us/articles/360001847227-Best-Practice-Optimize-Looker-Performance)\
      \ \n+ [Database Optimization](https://help.looker.com/hc/en-us/articles/360001828528-Best-Practice-Optimize-Database-Setup-for-Reading-Data)\
      \ \n+ [Leveraging PDTs](https://docs.looker.com/data-modeling/learning-lookml/derived-tables#persistent-derived-tables)\
      \ \n+ [Using Datagroups](https://docs.looker.com/data-modeling/learning-lookml/caching)"
    row: 29
    col: 0
    width: 24
    height: 4
  - title: Unlimited Downloads
    name: Unlimited Downloads
    model: system__activity
    explore: history
    type: looker_grid
    fields: [history.created_time, query.link, user.id, user.name]
    filters:
      query.limit: "-1"
    sorts: [history.created_time desc]
    limit: 100
    column_limit: 50
    show_view_names: true
    show_row_numbers: false
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
    truncate_column_names: false
    hidden_fields: []
    series_types: {}
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Downloading or Scheduling with the All Results option (Unlimited Download)  can
      potentially result in reduced performance on the Looker server.
    listen: {}
    row: 22
    col: 0
    width: 12
    height: 7
  - title: Most Frequently Scheduled Content
    name: Most Frequently Scheduled Content
    model: system__activity
    explore: scheduled_plan
    type: looker_column
    fields: [scheduled_job.created_date, scheduled_job.count, scheduled_job_rank.content_type_id]
    pivots: [scheduled_job_rank.content_type_id]
    fill_fields: [scheduled_job.created_date]
    filters:
      scheduled_job.created_date: 14 days
      scheduled_plan.run_once: 'No'
    sorts: [scheduled_job.created_date desc, zz_content_schedule_rank.content_schedule_rank,
      scheduled_job_rank.content_type_id desc]
    limit: 500
    column_limit: 25
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: Scheduled Job Count, orientation: left, series: [{axisId: Look
              17235 - 14002 - scheduled_job.count, id: Look 17235 - 14002 - scheduled_job.count,
            name: Look 17235}, {axisId: Look 17243 - 13537 - scheduled_job.count,
            id: Look 17243 - 13537 - scheduled_job.count, name: Look 17243}, {axisId: Look
              17847 - 13524 - scheduled_job.count, id: Look 17847 - 13524 - scheduled_job.count,
            name: Look 17847}, {axisId: Look 17236 - 12880 - scheduled_job.count,
            id: Look 17236 - 12880 - scheduled_job.count, name: Look 17236}, {axisId: Look
              17806 - 5152 - scheduled_job.count, id: Look 17806 - 5152 - scheduled_job.count,
            name: Look 17806}, {axisId: Look 7954 - 3828 - scheduled_job.count, id: Look
              7954 - 3828 - scheduled_job.count, name: Look 7954}, {axisId: Look 37540
              - 3816 - scheduled_job.count, id: Look 37540 - 3816 - scheduled_job.count,
            name: Look 37540}, {axisId: Look 40257 - 2795 - scheduled_job.count, id: Look
              40257 - 2795 - scheduled_job.count, name: Look 40257}, {axisId: Look
              37253 - 2262 - scheduled_job.count, id: Look 37253 - 2262 - scheduled_job.count,
            name: Look 37253}, {axisId: Look 41300 - 2041 - scheduled_job.count, id: Look
              41300 - 2041 - scheduled_job.count, name: Look 41300}, {axisId: Look
              42777 - 1235 - scheduled_job.count, id: Look 42777 - 1235 - scheduled_job.count,
            name: Look 42777}, {axisId: Look 41902 - 1215 - scheduled_job.count, id: Look
              41902 - 1215 - scheduled_job.count, name: Look 41902}, {axisId: Look
              38085 - 861 - scheduled_job.count, id: Look 38085 - 861 - scheduled_job.count,
            name: Look 38085}, {axisId: Look 42596 - 840 - scheduled_job.count, id: Look
              42596 - 840 - scheduled_job.count, name: Look 42596}, {axisId: Look
              39006 - 626 - scheduled_job.count, id: Look 39006 - 626 - scheduled_job.count,
            name: Look 39006}, {axisId: Look 36981 - 594 - scheduled_job.count, id: Look
              36981 - 594 - scheduled_job.count, name: Look 36981}, {axisId: Look
              42614 - 465 - scheduled_job.count, id: Look 42614 - 465 - scheduled_job.count,
            name: Look 42614}, {axisId: Look 37146 - 335 - scheduled_job.count, id: Look
              37146 - 335 - scheduled_job.count, name: Look 37146}, {axisId: Look
              37998 - 325 - scheduled_job.count, id: Look 37998 - 325 - scheduled_job.count,
            name: Look 37998}, {axisId: Look 37997 - 325 - scheduled_job.count, id: Look
              37997 - 325 - scheduled_job.count, name: Look 37997}, {axisId: Look
              9830 - 322 - scheduled_job.count, id: Look 9830 - 322 - scheduled_job.count,
            name: Look 9830}, {axisId: Look 42226 - 322 - scheduled_job.count, id: Look
              42226 - 322 - scheduled_job.count, name: Look 42226}, {axisId: Look
              42159 - 322 - scheduled_job.count, id: Look 42159 - 322 - scheduled_job.count,
            name: Look 42159}, {axisId: Look 39826 - 322 - scheduled_job.count, id: Look
              39826 - 322 - scheduled_job.count, name: Look 39826}, {axisId: Look
              39178 - 322 - scheduled_job.count, id: Look 39178 - 322 - scheduled_job.count,
            name: Look 39178}, {axisId: Look 37187 - 322 - scheduled_job.count, id: Look
              37187 - 322 - scheduled_job.count, name: Look 37187}, {axisId: Look
              37186 - 322 - scheduled_job.count, id: Look 37186 - 322 - scheduled_job.count,
            name: Look 37186}, {axisId: Look 37185 - 322 - scheduled_job.count, id: Look
              37185 - 322 - scheduled_job.count, name: Look 37185}, {axisId: Look
              37184 - 322 - scheduled_job.count, id: Look 37184 - 322 - scheduled_job.count,
            name: Look 37184}, {axisId: Look 30297 - 322 - scheduled_job.count, id: Look
              30297 - 322 - scheduled_job.count, name: Look 30297}, {axisId: Look
              30015 - 322 - scheduled_job.count, id: Look 30015 - 322 - scheduled_job.count,
            name: Look 30015}, {axisId: Look 29512 - 322 - scheduled_job.count, id: Look
              29512 - 322 - scheduled_job.count, name: Look 29512}, {axisId: Look
              25988 - 322 - scheduled_job.count, id: Look 25988 - 322 - scheduled_job.count,
            name: Look 25988}, {axisId: Look 24961 - 322 - scheduled_job.count, id: Look
              24961 - 322 - scheduled_job.count, name: Look 24961}, {axisId: Look
              17234 - 322 - scheduled_job.count, id: Look 17234 - 322 - scheduled_job.count,
            name: Look 17234}], showLabels: true, showValues: true, valueFormat: '',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: asc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: See which pieces of content make up the majority of scheduled jobs.
      In this tile schedule job counts are shown broken down by Content Type ID (i.e.
      “Look 546”). Individual stacks are ordered to show most frequently scheduled
      pieces of content at the top of each stack.
    listen: {}
    row: 16
    col: 12
    width: 12
    height: 6
  - title: Scheduled Job Avg Time in Queue Heatmap
    name: Scheduled Job Avg Time in Queue Heatmap
    model: system__activity
    explore: scheduled_plan
    type: looker_grid
    fields: [scheduled_job_stage.started_hour_of_day, scheduled_job_stage.started_day_of_week,
      scheduled_job_stage.avg_runtime, scheduled_job.count]
    pivots: [scheduled_job_stage.started_day_of_week]
    fill_fields: [scheduled_job_stage.started_hour_of_day, scheduled_job_stage.started_day_of_week]
    filters:
      scheduled_job_stage.stage: '"enqueue_for_execute"'
      scheduled_job.created_date: 7 days ago for 7 days
    sorts: [scheduled_job_stage.started_day_of_week 0, scheduled_job_stage.started_hour_of_day]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    series_labels:
      scheduled_job_stage.avg_runtime: Average Time in Queue
    series_cell_visualizations:
      scheduled_job_stage.avg_runtime:
        is_active: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#7d218f",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: afd46b40-e939-4ace-bffd-69d1bb16ee05, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: middle}, max: {type: maximum}}, mirror: true,
            reverse: true, stepped: false}}, bold: false, italic: false, strikethrough: false,
        fields: [scheduled_job_stage.avg_runtime]}, {type: along a scale..., value: !!null '',
        background_color: "#3EB0D5", font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          custom: {id: c092bb30-8fdb-9ce9-1a95-deab2cb82f73, label: Custom, type: continuous,
            stops: [{color: "#ffffff", offset: 0}, {color: "#d10a1b", offset: 100}]},
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: middle},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [scheduled_job.count]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    truncate_column_names: false
    series_types: {}
    listen: {}
    row: 2
    col: 0
    width: 16
    height: 12
  - title: Scheduled Jobs by Explore
    name: Scheduled Jobs by Explore
    model: system__activity
    explore: scheduled_plan
    type: looker_bar
    fields: [scheduled_job.count, query.view]
    filters:
      group.name: "-All Users"
      scheduled_job_stage.started_date: 7 days
    sorts: [scheduled_job.count desc]
    limit: 15
    column_limit: 50
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: ccba75a3-58c7-4b9c-a931-4ffc59e79cba
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: scheduled_job.count,
            id: scheduled_job.count, name: Scheduled Job}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '25'
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      scheduled_job.count: "#9174F0"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#7d218f",
        font_color: !!null '', color_application: {collection_id: 306fbe33-6921-4f0a-858c-5a679bc1bf08,
          palette_id: 72105a77-cea2-4d87-83df-00c4f0ab30ba, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: true, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen: {}
    row: 7
    col: 16
    width: 8
    height: 7
  - title: Outlier Days for Scheduled Jobs
    name: Outlier Days for Scheduled Jobs
    model: system__activity
    explore: scheduled_plan
    type: looker_column
    fields: [scheduled_job.finalized_date, query.count, scheduled_job_stage.avg_runtime]
    fill_fields: [scheduled_job.finalized_date]
    filters:
      scheduled_job.finalized_day_of_week: "-NULL"
    sorts: [scheduled_job.finalized_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: removes_maxmin, label: Removes Max/Min, expression: 'if(${scheduled_job_stage.avg_runtime}=max(${scheduled_job_stage.avg_runtime})
          OR ${scheduled_job_stage.avg_runtime}=min(${scheduled_job_stage.avg_runtime}),
          null, ${scheduled_job_stage.avg_runtime})', value_format: !!null '', value_format_name: decimal_2,
        _kind_hint: measure, _type_hint: number}, {table_calculation: standard_deviation_without_outliers,
        label: Standard Deviation (without outliers), expression: 'stddev_pop(${removes_maxmin})',
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: outlier, label: Outlier, expression: 'if(${scheduled_job_stage.avg_runtime}
          - mean(${removes_maxmin}) > 1.5*${standard_deviation_without_outliers},
          yes, no)', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: yesno}, {table_calculation: mean_with_no_outliers, label: Mean
          with no Outliers, expression: 'mean(${removes_maxmin})', value_format: !!null '',
        value_format_name: decimal_1, _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: Query Count, orientation: left, series: [{axisId: query.count,
            id: query.count, name: Query}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: scheduled_job_stage.avg_runtime, id: scheduled_job_stage.avg_runtime,
            name: Average Runtime in Seconds}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, type: log}]
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
    stacking: ''
    limit_displayed_rows: false
    hide_legend: true
    legend_position: center
    series_types:
      mean_with_no_outliers: line
    point_style: circle_outline
    series_colors:
      mean_with_no_outliers: "#E57947"
      query.count: "#4276BE"
      scheduled_job_stage.avg_runtime: "#B1399E"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#7d218f",
        font_color: !!null '', color_application: {collection_id: 306fbe33-6921-4f0a-858c-5a679bc1bf08,
          palette_id: 72105a77-cea2-4d87-83df-00c4f0ab30ba, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: true, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    hidden_fields: [removes_maxmin, standard_deviation_without_outliers, mean_with_no_outliers]
    hidden_points_if_no: [outlier]
    note_state: collapsed
    note_display: hover
    note_text: Outliers are days where Average Runtime exceeds (1.5 * standard deviation)
      of all the days with maximum and minimum Average Runtime values removed.
    listen: {}
    row: 2
    col: 16
    width: 8
    height: 5
  - title: Dashboards with more than 25 tiles
    name: Dashboards with more than 25 tiles
    model: system__activity
    explore: dashboard
    type: looker_grid
    fields: [dashboard.title, dashboard.link, dashboard_element.count_look, dashboard_element.count_lookless,
      dashboard_element.count_text, dashboard_element.count_merge_query, dashboard_element.count,
      query.count]
    filters:
      dashboard_element.count: ">25"
    sorts: [query.count desc]
    limit: 100
    dynamic_fields: [{table_calculation: total_query_tiles, label: Total Query Tiles,
        expression: "${dashboard_element.count}-${dashboard_element.count_text}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 592616d0-58e4-4968-9030-928ef38b7b50
      palette_id: e7303a54-e53e-4cf0-abc9-2f175c1128e0
    show_sql_query_menu_options: false
    column_order: [dashboard.title, dashboard.link, total_query_tiles, query.count,
      dashboard_element.count, dashboard_element.count_look, dashboard_element.count_lookless,
      dashboard_element.count_text, dashboard_element.count_merge_query]
    show_totals: true
    show_row_totals: true
    series_labels:
      query.count: Total Queries Generated
      dashboard_element.count_look: Look Tiles
      dashboard_element.count_lookless: Lookless Tiles
      dashboard_element.count_text: Text Tiles
      dashboard_element.count: Total Tiles
      dashboard_element.count_merge_query: Merge Query Tiles
    series_column_widths:
      total_query_tiles: 130
      dashboard_element.count: 89
      dashboard.title: 142
      dashboard.link: 88
      dashboard_element.count_look: 89
      query.count: 194
      dashboard_element.count_text: 89
      dashboard_element.count_lookless: 117
      dashboard_element.count_merge_query: 137
    series_cell_visualizations:
      dashboard_element.count_look:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1D98D3",
        font_color: !!null '', color_application: {collection_id: 592616d0-58e4-4968-9030-928ef38b7b50,
          palette_id: 721299c7-f114-43fc-926f-5bf0462bbfca, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 22}, max: {type: number,
                value: 25}}, mirror: false, reverse: true, stepped: false}}, bold: false,
        italic: false, strikethrough: false, fields: [total_query_tiles]}]
    truncate_column_names: true
    series_types: {}
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: Load times and general instance health may be impacted on dashboards
      with more than 25 tiles.
    defaults_version: 1
    listen: {}
    row: 22
    col: 12
    width: 12
    height: 7
  - name: Scheduler Performance
    type: text
    title_text: Scheduler Performance
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Dashboard with Auto-Refresh On
    name: Dashboard with Auto-Refresh On
    model: system__activity
    explore: dashboard
    type: looker_grid
    fields: [dashboard.title, dashboard.refresh_interval_ordered, user.name, dashboard.link,
      dashboard.id, dashboard_element.count, dashboard_element.count_text]
    filters:
      dashboard.refresh_interval_ordered: NOT NULL
      dashboard.deleted_date: 'NULL'
    sorts: [dashboard.refresh_interval_ordered]
    limit: 100
    dynamic_fields: [{table_calculation: non_text_tiles, label: Non-Text Tiles, expression: "${dashboard_element.count}-${dashboard_element.count_text}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: 592616d0-58e4-4968-9030-928ef38b7b50
      palette_id: e7303a54-e53e-4cf0-abc9-2f175c1128e0
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_cell_visualizations:
      dashboard_element.count:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1D98D3",
        font_color: !!null '', color_application: {collection_id: 592616d0-58e4-4968-9030-928ef38b7b50,
          custom: {id: e73dc266-945c-2a12-887f-a7f608e56229, label: Custom, type: continuous,
            stops: [{color: "#F36254", offset: 0}, {color: "#FCF758", offset: 50},
              {color: "#4FBC89", offset: 100}]}, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: middle}, max: {type: number, value: 3200}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [dashboard.refresh_interval_ordered]}, {type: along
          a scale..., value: !!null '', background_color: !!null '', font_color: !!null '',
        color_application: {collection_id: 592616d0-58e4-4968-9030-928ef38b7b50, palette_id: 721299c7-f114-43fc-926f-5bf0462bbfca,
          options: {steps: 5, reverse: true, constraints: {max: {type: number, value: 24}},
            stepped: false}}, bold: false, italic: false, strikethrough: false, fields: [
          non_text_tiles]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format:
      dashboard.id:
        name: id
        format_string: '0'
        label: ID
    hidden_fields: [dashboard_element.count, dashboard_element.count_text]
    note_state: collapsed
    note_display: hover
    note_text: |-
      Frequent dashboard updates, especially on large dashboards, can place a significant strain on some database systems.

      At minimum, avoid setting a refresh interval that is shorter than your database update interval, because there is no new data to refresh and it creates unnecessary queries.
    listen: {}
    row: 16
    col: 0
    width: 12
    height: 6
  - name: Taxing Content
    type: text
    title_text: Taxing Content
    row: 14
    col: 0
    width: 24
    height: 2
