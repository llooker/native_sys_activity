view: dashboard_filter {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: allow_multiple_values {
    type: yesno
  }

  dimension: dashboard_id {
    type: number
    hidden: yes
  }

  dimension: default_value {
    type: string
  }

  dimension_group: deleted {
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: dimension {
    type: string
  }

  dimension: explore {
    type: string
  }

  dimension: listens_to_filters_json {
    type: string
  }

  dimension: model_name {
    type: string
  }

  dimension: name {
    type: string
  }

  dimension: required {
    type: yesno
  }

  dimension: row {
    type: number
  }

  dimension: title {
    type: string
  }

  dimension: type {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [id, model_name, name, dashboard.id]
  }
}
