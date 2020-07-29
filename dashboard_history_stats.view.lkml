view: dashboard_history_stats {
  derived_table: {
    sql:
      SELECT
        dashboard_session,
        dashboard_id,
        COUNT(*) as total_queries,
        SUM(runtime) as total_runtime,
        MIN(runtime) as min_runtime,
        MAX(runtime) as max_runtime
      FROM history
      WHERE dashboard_session IS NOT NULL
      GROUP BY dashboard_session, dashboard_id ;;
  }

  dimension: dashboard_id {
    type: string
    hidden: yes
    sql: ${TABLE}.dashboard_id ;;
  }

  dimension: dashboard_session {
    hidden: yes
    description: "The unique numeric identifier for a single time the dashboard was loaded"
    }

  dimension: dashboard_id_as_number {
    hidden: yes
    type: number
    sql:
      {% if _dialect._name == 'hypersql' %}
        CASE WHEN REGEXP_MATCHES (${dashboard_id}, '^[0-9]+$')
          THEN CAST(${dashboard_id} AS INTEGER)
          ELSE 0
          END
      {% elsif _dialect._name == 'bigquery_standard_sql' %}
        CASE WHEN REGEXP_CONTAINS (${dashboard_id}, '^[0-9]+$')
          THEN CAST(${dashboard_id} AS INT64)
          ELSE 0
          END
      {% else %}
        CAST(${dashboard_id} AS SIGNED)
      {% endif %}
    ;;
  }

  dimension: max_runtime {
    description: "The longest amount of time taken to load the dashboard during the previous 90 days"
    type: number
  }

  dimension: min_runtime {
    description: "The shortest amount of time taken to load the dashboard during the previous 90 days"
    type: number
  }

  dimension: total_queries {
    description: "The cumulative number of queries run by the dashboard during the previous 90 days"
    type: number
  }

  dimension: total_runtime {
    description: "The cumulative total of time spent loading the dashboard during the previous 90 days"
    type: number
  }

  measure: avg_runtime {
    description: "The average time taken to load the dashboard during the previous 90 days"
    sql: SUM(${total_runtime}) / SUM(${total_queries}) ;;
  }
}
