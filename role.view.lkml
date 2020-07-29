view: role {

  dimension: id {
    description: "The unique numeric identifier for the role"
    primary_key: yes
    type: number
  }

  dimension: edit_link {
    description: "A clickable link to edit the role"
    type: string
    sql: ${id} ;;
    html: <a href='/admin/roles/{{value}}/edit'>Edit</a> ;;
  }

  dimension: built_in {
    description: "Is this a built-in role?"
    type: yesno
  }

  dimension: embed {
    description: "Is this an embedded user role?"
    type: yesno
  }

  dimension: model_set_id {
    type: number
    hidden: yes
  }

  dimension: name {
    description: "The name of the role"
    type: string
  }

  dimension: permission_set_id {
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
      id,
      name,
      permission_set.name,
      model_set.name,
    ]
  }
}
