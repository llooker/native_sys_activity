view: role_user {

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
  }

  dimension: role_id {
    type: number
    hidden: yes
  }

  dimension: user_id {
    type: number
    hidden: yes
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      role.id,
      role.name,
      user.dev_branch_name,
      user.last_name,
      user.first_name,
      user.id
    ]
  }
}
