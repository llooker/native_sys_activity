view: dashboard_run_session_filter_usage {
  derived_table: {
    sql:
     SELECT
      event_attribute.value as run_session_id
      ,event_filters_json.filters_json as filters_json
        FROM (
          SELECT
            event_id
            , CONCAT('{',
            {% if _dialect._name == 'hypersql' or _dialect._name == 'mysql' %}
              group_concat(quoted_pair SEPARATOR ', ')
            {% elsif _dialect._name == 'bigquery_standard_sql' %}
              STRING_AGG(quoted_pair, ", ")
            {% elsif _dialect._name == 'snowflake' %}
              LISTAGG(quoted_pair, ', ')
            {% endif %}
            , '}') AS filters_json
          FROM (
            SELECT
              event_id
              ,CONCAT('"', filter_name, '":"', filter_value, '"') as quoted_pair
            FROM (
              SELECT
                event_attribute.EVENT_ID AS event_id
                ,
                {% if _dialect._name == 'hypersql' or _dialect._name == 'mysql' %}
                  SUBSTRING(event_attribute.NAME, 8)
                {% elsif _dialect._name == 'bigquery_standard_sql' %}
                  SUBSTR(event_attribute.NAME, 8)
                {% elsif _dialect._name == 'snowflake' %}
                  SUBSTRING(event_attribute.NAME, 8)
                {% endif %}
                AS filter_name
                ,event_attribute.VALUE AS filter_value
              FROM event_attribute
              WHERE
                  (event_attribute.NAME LIKE 'filter%')
            ) clean_data
          ) make_pairs
          GROUP BY event_id
        ) event_filters_json
        LEFT JOIN event_attribute ON event_filters_json.event_id = event_attribute.event_id AND event_attribute.name = 'run_session_id' ;;
  }

  dimension: run_session_id {
    hidden: yes
    type: string
  }

  dimension: filter_json {
    description: "A JSON string describing the dashboard filter configuration when the dashboard was loaded"
    type: string
    view_label: "Dashboard Run"
    sql: ${TABLE}.filters_json ;;
  }
}
