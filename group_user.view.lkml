view: group_user {

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
  }

  dimension: from_group_id {
    type: number
    hidden: yes
  }

  dimension: group_id {
    type: number
    hidden: yes
  }

  dimension: user_id {
    type: number
    hidden: yes
  }

  dimension: is_direct_group {
    view_label: "Group"
    type: yesno
    sql: ${from_group_id} = ${group_id} ;;
    description:
      "Was the user directly added to this group, rather than inheriting this group by being a member of a child group?"
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      user.dev_branch_name,
      user.last_name,
      user.first_name,
      user.id,
      group.name,
      group.id
    ]
  }
}
