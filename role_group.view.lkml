view: role_group {

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
  }

  dimension: group_id {
    type: number
    hidden: yes
  }

  dimension: role_id {
    type: number
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, role.id, role.name, group.name, group.id]
  }
}
