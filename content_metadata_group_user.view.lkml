view: content_metadata_group_user {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: content_metadata_id {
    type: number
    # hidden: yes
  }

  dimension: group_id {
    type: number
    # hidden: yes
  }

  dimension: permission_type {
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
      group.name,
      group.id,
      user.dev_branch_name,
      user.last_name,
      user.first_name,
      user.id,
      content_metadata.id
    ]
  }
}
