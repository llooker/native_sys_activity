view: scheduled_job_stage {

  dimension: id {
    primary_key: yes
    description: "The unique numeric identfier for a stage of a scheduled job"
    type: number
  }

  dimension_group: completed {
    description: "When the scheduled job's stage completed"
    type: time
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            TIMESTAMP_MICROS(${TABLE}.COMPLETED_AT)
          {% else %}
            ${TABLE}.COMPLETED_AT
          {% endif %} ;;
  }

  dimension: node_id {
    description: "The node that the stage of the scheduled job was executed on"
    type: number
    # hidden: true
  }

  dimension: runtime {
    label: "Runtime in Seconds"
    description: "The number of seconds a scheduled job took to run"
    type: number
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            TIMESTAMP_DIFF(${completed_raw}, ${started_raw}, second)
          {% else %}
            TIMESTAMPDIFF(SQL_TSI_SECOND, ${started_raw}, ${completed_raw})
          {% endif %} ;;
  }

  dimension: scheduled_job_id {
    description: "The unique numeric identifier for a scheduled job"
    type: number
    # hidden: true
  }

  dimension: stage {
    description: "The stage or 'state' of the scheduled job"
    type: string
  }

  dimension_group: started {
    description: "When the scheduled job's stage started"
    type: time
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            TIMESTAMP_MICROS(${TABLE}.STARTED_AT)
          {% else %}
            ${TABLE}.STARTED_AT
          {% endif %} ;;
  }

  measure: avg_runtime {
    label: "Average Runtime in Seconds"
    description: "The scheduled job's stage's average run time in seconds"
    type: average
    sql: ${runtime};;
    value_format_name: decimal_1
    drill_fields: [ scheduled_job.name, user.name, avg_runtime ]
  }

  measure: count {
    type: count
    drill_fields: [id, scheduled_job.id, scheduled_job.name, node.id, node.hostname]
  }
}
