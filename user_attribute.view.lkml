view: user_attribute {
  sql_table_name: user_attribute_v2 ;;

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: is_system {
    type: yesno
  }

  dimension: label {
    type: string
  }

  dimension: name {
    type: string
  }

  dimension: type {
    type: string
  }

  dimension: user_can_edit {
    type: yesno
  }

  dimension: user_can_view {
    type: yesno
  }

  dimension: value_is_hidden {
    type: yesno
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      user.dev_branch_name,
      user.last_name,
      user.first_name,
      user.id,
      user_attribute_group_value.count,
      user_attribute_user_value.count
    ]
  }


}
