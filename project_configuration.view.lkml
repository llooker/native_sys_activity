view: project_configuration {

  dimension: git_service_name {
    type: string
  }

  dimension: lookml_type {
    type: string
  }

  dimension: project_id {
    type: string
  }

  dimension: pull_request_mode {
    type: string
  }

  dimension: validation_required {
    type: yesno
  }

  dimension: folders_enabled {
    type: yesno
  }

  measure: count {
    type: count
    drill_fields: [git_service_name]
  }
}
