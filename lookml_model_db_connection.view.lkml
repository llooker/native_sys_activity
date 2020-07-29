view: lookml_model_db_connection {
  label: "LookML Model DB Connection"

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: db_connection_id {
    type: number
    # hidden: yes
  }

  dimension: lookml_model_id {
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
      lookml_model.id,
      lookml_model.name,
      lookml_model.project_name,
      db_connection.id,
      db_connection.name,
    ]
  }
}
