view: field_usage {

  dimension: id {
    description: "The unique numeric identifier for the field"
    primary_key: yes
    type: number
  }

  dimension: explore {
    description: "The Explore from which the field is pulled"
    alias: [field_usage.base_view]
    type: string
    sql: ${TABLE}.BASE_VIEW ;;
  }

  dimension: view {
    description: "The view to which the field belongs. NOTE: The view's alias will appear here if using the `from:` parameter at the Explore level."
    sql:
    {% if _dialect._name == 'bigquery_standard_sql' %}
      IF(STRPOS(${field}, ".") > 0
        ,SPLIT(${field}, ".")[OFFSET(0)]
        ,"N/A: Custom Field"
      )
    {% else %}
      CASE WHEN POSITION('.' IN ${field}) > 0
        THEN
          SUBSTR(${field}, 1, POSITION('.' IN ${field})-1)
        ELSE
          'N/A: Custom Field'
        END
    {% endif %}
    ;;
  }

  dimension: field {
    description: "The fully-scoped name of the field"
    type: string
  }

  dimension: model {
    description: "The model from which the field is pulled"
    type: string
  }

  dimension: times_used_dim {
    sql: ${TABLE}.times_used ;;
    hidden: yes
    description: "The number of times this field has been used"
    type: number
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  measure: times_used {
    description: "The number of times a field from a explore/view has been used. If \"Field\" is selected, this represents the number of times that particular field was used"
    type: sum
    sql: ${times_used_dim} ;;
  }

}
