view: access_token {

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

  dimension: grant_type {
    type: string
  }

  dimension: user_id {
    type: number
    hidden: yes
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
      created_time,
      expires_time,
      grant_type,
      user.last_name,
      user.first_name,
      user.id,
      user.dev_branch_name
    ]
  }
}
