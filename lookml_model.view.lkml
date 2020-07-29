view: lookml_model {
  label: "LookML Model"

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: name {
    type: string
  }

  dimension: project_name {
    type: string
  }

  dimension: unlimited_db_connections {
    type: yesno
  }

  measure: count {
    type: count
    drill_fields: [id, name, project_name, lookml_model_db_connection.count]
  }
}
