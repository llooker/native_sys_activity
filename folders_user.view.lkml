view: folders_user {
  sql_table_name: space_user ;;

  dimension: space_id {
    type: number
    hidden: yes
  }

  dimension: user_id {
    type: number
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      folders.name,
      folders.id,
      user.dev_branch_name,
      user.last_name,
      user.first_name,
      user.id
    ]
  }
}
