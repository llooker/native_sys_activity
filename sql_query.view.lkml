view: sql_query {
  label: "SQL Runner Query"

  dimension: id {
    description: "The unique numeric identifier for a query"
    primary_key: yes
    type: number
  }

  dimension: connection_id {
    description: "The name of the database connection used for the query"
    type: string
  }

  dimension: hash {
    description: "The query's unique string ID identifier, calculated from the generated SQL text"
    type: string
  }

  dimension_group: last_run {
    description: "When the query was last run"
    type: time
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            TIMESTAMP_MICROS(${TABLE}.LAST_RUN_AT)
          {% else %}
            ${TABLE}.LAST_RUN_AT
          {% endif %} ;;
  }

  dimension: last_runtime {
    description: "The duration of the last query run"
    type: number
  }

  dimension: result_set_metadata {
    description: "The query's JSON encoded metadata"
    type: string
  }

  dimension: run_count {
    description: "The number of times the query was run"
    type: number
  }

  dimension: slug {
    description: "The query's unique string ID, included in the URL"
    type: string
  }

  dimension: sql {
    description: "The text of the SQL query"
    type: string
  }

  dimension: user_id {
    description: "The unique numeric ID of the user who created the query"
    type: number
    # hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      slug,
      connection_id,
      user_id,
      user.name,
      last_run_date,
      run_count,
    ]
  }
}
