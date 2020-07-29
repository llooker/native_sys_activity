view: content_favorite {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: content_metadata_id {
    type: number
    # hidden: yes
  }

  dimension: dashboard_id {
    type: number
    # hidden: yes
  }

  dimension: look_id {
    type: number
    # hidden: yes
  }

  dimension: lookml_dashboard_id {
    type: string
  }

  dimension: user_id {
    type: number
    # hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      dashboard.id,
      user.dev_branch_name,
      user.last_name,
      user.first_name,
      user.id,
      content_metadata.id,
      look.id
    ]
  }
}
