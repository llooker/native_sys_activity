view: merge_query {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: column_limit { type: number }

  dimension_group: created {
    type: time
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            TIMESTAMP_MICROS(${TABLE}.CREATED_AT)
          {% else %}
            ${TABLE}.CREATED_AT
          {% endif %} ;;
  }

  dimension: hash {}

  dimension: pivots {
    hidden: yes
  }

  dimension: formatted_pivots {
    label: "Pivots Used"
    sql: REPLACE(${pivots}, ',', ', ') ;;
  }

  dimension: sorts {}
  dimension: total { type: yesno }
  dimension: vis_config {}
  dimension: dynamic_fields {
    label: "Table Calculations"
  }

  measure: count {
    type: count
  }
}
