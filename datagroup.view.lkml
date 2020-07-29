view: datagroup {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension_group: created {
    type: time
    datatype: epoch
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: model_name {
    type: string
  }

  dimension: name {
    type: string
  }

  dimension_group: stale_before {
    type: time
    datatype: epoch
    sql:  ${TABLE}.STALE_BEFORE ;;
  }

  dimension_group: trigger_check {
    type: time
    datatype: epoch
    sql: ${TABLE}.TRIGGER_CHECK_AT ;;
  }

  dimension: trigger_error {
    type: string
  }

  dimension: trigger_value {
    type: string
  }

  dimension_group: triggered {
    type: time
    datatype: epoch
    sql: ${TABLE}.TRIGGERED_AT ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, model_name]
  }
}
