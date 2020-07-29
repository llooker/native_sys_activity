
# Groups all relevant event attributes for a dashboard load together
# so they can be one-to-one joined with history stats about that dashboard load
# and aggregates will work on hypersql
view: dashboard_run_event_stats {
  derived_table: {
    sql:
      SELECT
        MIN(ran_at) AS first_event_at,
        MAX(ran_at) AS last_event_at,
        MAX(dashboard_run_start) as dashboard_run_start,
        MIN(received_at) as first_data_received_at,
        MAX(received_at) as last_data_received_at,
        MIN(rendered_at) as first_tile_finished_rendering,
        MAX(rendered_at) as last_tile_finished_rendering,
        dashboard_run_session,
        dashboard_page_session
      FROM
        (SELECT
          event.created_at AS ran_at,
          MAX(CASE WHEN event_attribute.NAME = 'run_session_id' THEN event_attribute.VALUE ELSE NULL END) as dashboard_run_session,
          MAX(CASE WHEN event_attribute.NAME = 'load_session_id' THEN event_attribute.VALUE ELSE NULL END) as dashboard_page_session,
          MAX(CASE WHEN event_attribute.NAME = 'started_at' AND event.NAME = 'dashboard.run.start' THEN CAST(event_attribute.VALUE AS
            {% if _dialect._name == 'hypersql' %}
              FLOAT
            {% elsif _dialect._name == 'bigquery_standard_sql' %}
              FLOAT64
            {% else %}
              decimal
            {% endif %}
          ) ELSE NULL END) as dashboard_run_start,
          MAX(CASE WHEN event_attribute.NAME = 'rendered_at' AND event.NAME = 'dashboard.run.data_rendered' THEN CAST(event_attribute.VALUE AS
            {% if _dialect._name == 'hypersql' %}
              FLOAT
            {% elsif _dialect._name == 'bigquery_standard_sql' %}
              FLOAT64
            {% else %}
              decimal
            {% endif %}
          ) ELSE NULL END) as rendered_at,
          MAX(CASE WHEN event_attribute.NAME = 'received_at' AND event.NAME = 'dashboard.run.data_received' THEN CAST(event_attribute.VALUE AS
            {% if _dialect._name == 'hypersql' %}
              FLOAT
            {% elsif _dialect._name == 'bigquery_standard_sql' %}
              FLOAT64
            {% else %}
              decimal
            {% endif %}
          ) ELSE NULL END) as received_at
        FROM event LEFT JOIN event_attribute
          ON event.ID = event_attribute.EVENT_ID
        WHERE event.CATEGORY = 'dashboard_performance'
        GROUP BY event.id, event.created_at) aliased
      WHERE dashboard_run_session IS NOT NULL
      GROUP BY dashboard_run_session, dashboard_page_session ;;
  }

  dimension: dashboard_run_session {
    primary_key: yes
    description: "The unique string identifier assigned to a particular dashboard each time the dashboard is run"
    type: string
  }

  dimension: dashboard_page_session {
    description: "A unique string identifier assigned to a particular dashboard each time a dashboard page is loaded"
    type: string
  }

  dimension: seconds_until_dashboard_run_start {
    sql: ${TABLE}.dashboard_run_start / 1000 ;;
    value_format: "0.###"
    description: "The number of seconds that passed before the dashboard loaded and the ‘Run’ button was clicked"
    type: number
  }

  dimension: seconds_until_first_data_received {
    description: "The number of seconds that passed before the first query results were returned to the dashboard"
    sql: ${TABLE}.first_data_received_at / 1000 ;;
    value_format: "0.###"
    type: number
  }

  dimension: seconds_until_last_data_received {
    description: "The number of seconds that passed before the last query results were returned to the dashboard"
    sql: ${TABLE}.last_data_received_at / 1000 ;;
    value_format: "0.###"
    type: number
  }

  dimension: seconds_until_first_tile_finished_rendering {
    description: "The number of seconds that passed before the first dashboard tile was displayed with query results"
    sql: ${TABLE}.first_tile_finished_rendering / 1000 ;;
    value_format: "0.###"
    type: number
  }

  dimension: seconds_until_last_tile_finished_rendering {
    description: "The number of seconds that passed before the last dashboard tile was displayed with query results"
    sql: ${TABLE}.last_tile_finished_rendering / 1000 ;;
    value_format: "0.###"
    type: number
  }

  dimension_group: first_event_at {
    description: "The first occurrence of a particular dashboard being run"
    type: time
  }

  dimension_group: last_event_at {
    description: "The last occurrence of a particular dashboard being run"
    type: time
  }

  measure: count {
    type: count
    description: "The number of unique sessions that are created each time a dashboard is run"
  }
}
