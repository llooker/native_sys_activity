view: dashboard_page_event_stats {
  derived_table: {
    sql:
      SELECT
        MIN(loaded_at) AS first_event_at,
        MAX(loaded_at) AS last_event_at,
        MAX(controller_initialized_at) as controller_initialized_at,
        MAX(metadata_loaded_at) as metadata_loaded_at,
        MAX(dom_content_loaded) as dom_content_loaded,
        dashboard_page_session
      FROM
        (SELECT
            event.created_at AS loaded_at,
            MAX(CASE WHEN event_attribute.NAME = 'dom_content_loaded' AND event.NAME = 'dashboard.load.initialized' THEN CAST(event_attribute.VALUE AS
              {% if _dialect._name == 'hypersql' %}
                FLOAT
              {% elsif _dialect._name == 'bigquery_standard_sql' %}
                FLOAT64
              {% else %}
                decimal
              {% endif %}
            ) ELSE NULL END) as dom_content_loaded,
            MAX(CASE WHEN event_attribute.NAME = 'load_session_id' THEN event_attribute.VALUE ELSE NULL END) as dashboard_page_session,
            MAX(CASE WHEN event_attribute.NAME = 'controller_initialized_at' AND event.NAME = 'dashboard.load.initialized' THEN CAST(event_attribute.VALUE AS
              {% if _dialect._name == 'hypersql' %}
                FLOAT
              {% elsif _dialect._name == 'bigquery_standard_sql' %}
                FLOAT64
              {% else %}
                decimal
              {% endif %}
            ) ELSE NULL END) as controller_initialized_at,
            MAX(CASE WHEN event_attribute.NAME = 'metadata_loaded_at' AND event.NAME = 'dashboard.load.metadata' THEN CAST(event_attribute.VALUE AS
              {% if _dialect._name == 'hypersql' %}
                FLOAT
              {% elsif _dialect._name == 'bigquery_standard_sql' %}
                FLOAT64
              {% else %}
                decimal
              {% endif %}
            ) ELSE NULL END) as metadata_loaded_at
          FROM event LEFT JOIN event_attribute
            ON event.ID = event_attribute.EVENT_ID
          WHERE event.CATEGORY = 'dashboard_performance'
          GROUP BY event.id, event.created_at) aliased
      GROUP BY dashboard_page_session ;;
  }

  dimension: dashboard_page_session {
    primary_key: yes
    hidden: yes
    description: "A unique string identifier assigned to a particular dashboard each time a dashboard page is loaded"
  }

  dimension_group: first_event_at {
    description: "The first occurrence of a particular dashboard being run"
    type: time
  }

  dimension_group: last_event_at {
    description: "The last occurrence of a particular dashboard being run"
    type: time
  }

  dimension: seconds_until_controller_initialized {
    sql: ${TABLE}.controller_initialized_at / 1000 ;;
    value_format: "0.###"
    description: "The number of seconds that passed before the last query results were returned to the dashboard"
    type: number

  }

  dimension: seconds_until_metadata_loaded {
    sql: ${TABLE}.metadata_loaded_at / 1000 ;;
    value_format: "0.###"
    description: "The number of seconds that passed before metadata was loaded on the dashboard page"
    type: number
  }

  dimension: seconds_until_dom_content_loaded {
    sql: ${TABLE}.dom_content_loaded / 1000 ;;
    value_format: "0.###"
    description: "The number of seconds that passed before the document object model (DOM) was loaded on the dashboard page"
    type: number
  }
}
