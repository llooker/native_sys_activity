view: login_attempt {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: expires {
    type: time
    sql: ${TABLE}.EXPIRES_AT ;;
  }

  dimension: ip {
    type: string
  }

  dimension: key {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
