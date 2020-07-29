view: dashboard {

  dimension: id {
    primary_key: yes
    label: "ID (User-defined only)"
    description: "The unique numeric identifier for a user-defined dashboard"
    type: number
  }

  dimension: background_color {
    description: "The color of the dashboard background as a hex string or CSS color name"
    type: string
  }

  dimension: content_metadata_id {
    type: number
    hidden: yes
  }

  dimension_group: created {
    description: "When this dashboard was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: deleted {
    description: "When the dashboard was deleted. If the dashboard has not been deleted, this field is null."
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: deleter_id {
    description: "The unique numeric ID of the user who deleted the dashboard. If the dashboard has not been deleted, this field is null."
    type: number
  }

  dimension: description {
    description: "The description assigned to the dashboard"
    type: string
  }

  dimension: hidden {
    description: "Is the dashboard configured to be hidden?"
    type: yesno
  }

  dimension: link {
    skip_drill_filter: yes
    description: "A clickable link to the dashboard URL"
    sql: ${id} ;;
    html: [<a href="/dashboards/{{ value }}" rel="noopener">Dashboard</a>] ;;
  }

  # The `load_configuration` field determines how the dashboard will be loaded. Values can be:
    # cache_run (will attempt to read queries from cache and will run them if nothing is found (default)),
    # wait (will show a run button and wait to run when the user clicks it),
    # prefetch_cache_run (will first attempt to read entire dashboard prefetch and then cache and run),
    # prefetch_wait (will attempt to read from dashboard prefetch and then waits for user to hit run to actually run queries),
    # prefetch_only (will attempt to read from dashboard prefetch and will not expose run button to user)
    # This field is typically `cache_run` or null via a toggle in the UI. Other options are set via API and are rare.
  dimension: load_configuration {
    type: string
    hidden: yes
  }

  dimension: run_on_load {
    description: "Is the dashboard configured to automatically load data when it is opened?"
    type: yesno
    sql: ${load_configuration} is null ;;
  }

  dimension: query_timezone {
    description: "The default timezone for the dashboard's queries"
    type: string
  }

  dimension: refresh_interval {
    hidden: yes
    description: "The frequency with which the dashboard will refresh if auto-refresh is enabled. If auto-refresh is disabled, the value of this field is null."
    type: string
    order_by_field: refresh_interval_ordered
  }

  dimension: refresh_interval_ordered {
    label: "Refresh Interval"
    description: "The frequency with which the dashboard will refresh if auto-refresh is enabled. If auto-refresh is disabled, the value of this field is null."
    type: number
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            CASE WHEN ${refresh_interval} LIKE '%second%' THEN CAST(SPLIT(${refresh_interval}, ' ')[OFFSET(0)] AS INT64)
              WHEN ${refresh_interval} LIKE '%minute%' THEN CAST(SPLIT(${refresh_interval}, ' ')[OFFSET(0)] AS INT64)*60
              WHEN ${refresh_interval} LIKE '%hour%' THEN CAST(SPLIT(${refresh_interval}, ' ')[OFFSET(0)] AS INT64)*60*60
              WHEN ${refresh_interval} LIKE '%day%' THEN CAST(SPLIT(${refresh_interval}, ' ')[OFFSET(0)] AS INT64)*24*60*60
              ELSE CAST(SPLIT(${refresh_interval}, ' ')[OFFSET(0)] AS INT64)
            END
          {% elsif _dialect._name == 'snowflake' %}
            CASE WHEN ${refresh_interval} LIKE '%second%' THEN CAST(SPLIT_PART(${refresh_interval}, ' ', 1) AS INTEGER)
              WHEN ${refresh_interval} LIKE '%minute%' THEN CAST(SPLIT_PART(${refresh_interval}, ' ', 1) AS INTEGER)*60
              WHEN ${refresh_interval} LIKE '%hour%' THEN CAST(SPLIT_PART(${refresh_interval}, ' ', 1) AS INTEGER)*60*60
              WHEN ${refresh_interval} LIKE '%day%' THEN CAST(SPLIT_PART(${refresh_interval}, ' ', 1) AS INTEGER)*24*60*60
              ELSE CAST(SPLIT_PART(${refresh_interval}, ' ', 1) AS INTEGER)
            END
          {% elsif _dialect._name == 'mysql' %}
            CASE WHEN ${refresh_interval} LIKE '%second%' THEN CAST(SUBSTRING_INDEX(${refresh_interval}, ' ', 1) AS UNSIGNED)
              WHEN ${refresh_interval} LIKE '%minute%' THEN CAST(SUBSTRING_INDEX(${refresh_interval}, ' ', 1) AS UNSIGNED)*60
              WHEN ${refresh_interval} LIKE '%hour%' THEN CAST(SUBSTRING_INDEX(${refresh_interval}, ' ', 1) AS UNSIGNED)*60*60
              WHEN ${refresh_interval} LIKE '%day%' THEN CAST(SUBSTRING_INDEX(${refresh_interval}, ' ', 1) AS UNSIGNED)*24*60*60
              ELSE CAST(SUBSTRING_INDEX(${refresh_interval}, ' ', 1) AS UNSIGNED)
            END
          {% else %}
            ${refresh_interval}
          {% endif %} ;;
    html: {{ refresh_interval._value }} ;;
  }

  dimension: show_filters_bar {
    description: "Is the dashboard configured to display its filters bar?"
    type: yesno
  }

  dimension: show_tile_shadow {
    description: "Is the dashboard configured to display a shadow around tile borders?"
    type: yesno
  }

  dimension: show_title {
    description: "Is the dashboard configured to display its title?"
    type: yesno
  }

  dimension: space_id {
    type: number
    hidden: yes
  }

  dimension: text_tile_text_color {
    description: "The color of the text in the dashboard's tiles as a hex string or CSS color name"
    type: string
  }

  dimension: tile_background_color {
    description: "The dashboard tiles' background color as a hex string or CSS color name"
    type: string
  }

  dimension: tile_border_radius {
    description: "The thickness of the borders around dashboard tiles"
    type: number
  }

  dimension: tile_separator_color {
    description: "The color of the separators between dashboard tiles as a hex string or CSS color name"
    type: string
  }

  dimension: tile_text_color {
    description: "The color of the text in the dashboard tiles as a hex string or CSS color name"
    type: string
  }

  dimension: title {
    description: "The title of the dashboard as a clickable link"
    type: string
    sql: ${TABLE}.TITLE ;;
    html: <a href="/dashboards/{{ id._value }}" rel="noopener">{{value}}</a> ;;
  }

  dimension: title_color {
    description: "The color of the dashboard title as a hex string or CSS color name"
    type: string
  }

  dimension: user_id {
    type: number
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [dashboard_detail*]
  }

  measure: count_last_30_days {
    description: "Dashboards created in the last 30 days"
    type: count
    filters: {
      field: created_date
      value: "last 30 days"
    }
    drill_fields: [dashboard_detail*]
  }


  # ----- Sets of fields for drilling ------
  set: dashboard_detail {
    fields: [
      id,
      title,
      created_date,
      deleted_date,
      folders.name,
      user.last_name,
      user.first_name,
      content_favorite.count,
      dashboard_element.count,
      history.count,
      scheduled_plan.count
    ]
  }

  set: history_detail {
    fields: [
      id,
      run_on_load,
      description,
      hidden,
      link,
      title,
      count,
      refresh_interval,
      refresh_interval_ordered,
      created_date,
      created_day_of_month,
      created_day_of_week,
      created_day_of_week_index,
      created_hour,
      created_hour_of_day,
      created_minute,
      created_month,
      created_month_name,
      created_month_num,
      created_quarter,
      created_quarter_of_year,
      created_time,
      created_time_of_day,
      created_week,
      created_week_of_year,
      created_year,
      deleted_date,
      deleted_day_of_month,
      deleted_day_of_week,
      deleted_day_of_week_index,
      deleted_hour,
      deleted_hour_of_day,
      deleted_minute,
      deleted_month,
      deleted_month_name,
      deleted_month_num,
      deleted_quarter,
      deleted_quarter_of_year,
      deleted_time,
      deleted_time_of_day,
      deleted_week,
      deleted_week_of_year,
      deleted_year
    ]
  }
}
