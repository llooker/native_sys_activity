view: pdt_builds {
  label: "PDT Builds"
  derived_table: {
    explore_source: pdt_event_log {
      column: tid      { field: pdt_event_log.tid }
      column: transaction_start { field: pdt_event_log.earliest_created }
      column: transaction_end { field: pdt_event_log.latest_created }
      column: status   { field: pdt_event_log.status }
      column: context { field: pdt_event_log.create_context }
      column: connection { field: pdt_event_log.connection }
      column: model_name { field: pdt_event_log.model_name }
      column: view_name { field: pdt_event_log.view_name }
      filters: {
        field: pdt_event_log.action
        value: "create%"
      }
    }
  }

  dimension: tid {
    description: "The unique transaction ID for each occurence of a PDT build"
    hidden: yes
    primary_key: yes
  }

  dimension: status {
    description: "The status of the PDT build process"
  }

  dimension: context {
    description: "The workspace and optional user id e.g. dev-user-42"
  }

  dimension: workspace {
    description: "The workspace of the PDT build process"
    sql:
      {% if _dialect._name == 'hypersql' %}
        CASE substr(${context}, 1, 4)
          WHEN 'prod' THEN 'prod'
          ELSE ${context}
        END
      {% else %}
        CASE
          WHEN ${context} LIKE 'prod%' THEN 'prod'
          ELSE ${context}
        END
      {% endif %} ;;
  }

  dimension: dev_build {
    type: yesno
    description: "The build was initiated by a dev mode query"
    sql: ${context} LIKE 'dev%' ;;
  }

  dimension: connection {
    description: "The database connection used by the PDT query"
    type: string
    sql: ${TABLE}.connection ;;
  }

  dimension: model_name {
    description: "The name of the model in which the PDT view is saved"
    type: string
    sql: ${TABLE}.model_name ;;
  }

  dimension: view_name {
    description: "The view name of the PDT"
    type: string
    sql: ${TABLE}.view_name ;;
  }

  dimension_group: start {
    description: "The start time of the PDT build occurrence"
    type: time
    sql: ${TABLE}.transaction_start ;;
    datatype: epoch
  }

  dimension_group: end {
    description: "The end time of the PDT build occurrence"
    type: time
    sql: ${TABLE}.transaction_end ;;
    datatype: epoch
  }

  dimension: elapsed_seconds {
    description: "The number of seconds (in integers) between the start and end times of the PDT build process"
    type: number
    sql: ${TABLE}.transaction_end - ${TABLE}.transaction_start ;;
  }

  dimension: elapsed_minutes_float {
    description: "The number of minutes (as a decimal) between the start and end times of the PDT build process"
    hidden: yes
    type: number
    sql:
      {% if _dialect._name == 'hypersql' %}
        CAST(${elapsed_seconds} AS FLOAT) / 60.0
      {% elsif _dialect._name == 'bigquery_standard_sql' %}
        ${elapsed_seconds} / 60.0
      {% else %}
        ${elapsed_seconds} / 60.0
      {% endif %};;
  }

  dimension: elapsed_minutes {
    description: "The number of minutes (rounded to 2 decimal points) between the start and end times of the PDT build process"
    type: number
    value_format_name: "decimal_2"
    sql:
      {% if _dialect._name == 'hypersql' %}
        CASE WHEN status LIKE 'done' THEN ${elapsed_minutes_float} ELSE NULL END
      {% elsif _dialect._name == 'bigquery_standard_sql' %}
        CASE WHEN status LIKE 'done' THEN ${elapsed_minutes_float} ELSE NULL END
      {% else %}
        CASE WHEN status LIKE 'done' THEN CAST(${elapsed_minutes_float} AS DECIMAL(14,2)) ELSE NULL END
      {% endif %};;
  }

  measure: count {
    description: "The number of PDT build occurrences"
    type: count
    drill_fields: [detail*]
  }

  measure: average_build_time_seconds {
    description: "The average number of seconds to build included PDTs"
    type: average
    sql: ${elapsed_seconds} ;;
    drill_fields: [detail*]
  }

  measure: average_build_time_minutes {
    description: "The average number of minutes (rounded to 2 decimal points) to build aggregated PDTs"
    type: average
    sql: ${elapsed_minutes} ;;
    value_format_name: "decimal_2"
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      pdt_event_log.view_name,
      pdt_event_log.table_name,
      tid,
      status,
      start_time,
      elapsed_minutes,
      pdt_event_log.count
    ]
  }
}
