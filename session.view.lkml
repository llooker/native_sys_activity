view: session {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: browser {
    type: string
  }

  dimension: city {
    type: string
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
    map_layer_name: countries
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: credentials_type {
    type: string
  }

  dimension_group: expires {
    type: time
    sql: ${TABLE}.EXPIRES_AT ;;
  }

  dimension_group: extended {
    type: time
    sql: ${TABLE}.EXTENDED_AT ;;
  }

  dimension: extended_count {
    type: number
  }

  dimension: ip_address {
    type: string
  }

  dimension: operating_system {
    type: string
  }

  dimension: state {
    type: string
  }

  dimension: sudo_url {
    type: string
  }

  dimension: sudo_user_id {
    type: number
  }

  dimension: user_id {
    type: number
    # hidden: yes
  }

  dimension: user_overrides_workspace {
    type: yesno
  }

  dimension: workspace_id {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      user.dev_branch_name,
      user.last_name,
      user.first_name,
      user.id
    ]
  }
}
