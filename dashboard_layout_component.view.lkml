view: dashboard_layout_component {

  dimension: id {
    description: "The unique numeric identifier for the dashboard tile"
    primary_key: yes
    type: number
  }

  dimension: column {
    description: "The dashboard column in which the dashboard tile is located"
    type: number
  }

  dimension_group: created {
    description: "The date and time the dashboard tile was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: dashboard_element_id {
    type: number
    hidden: yes
  }

  dimension: dashboard_layout_id {
    type: number
    hidden: yes
  }

  dimension_group: deleted {
    description: "The date and time the dashboard tile was deleted. A tile that has not been deleted has a value of null."
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: height {
    description: "The height of the dashboard tile, in units defined by tile_size (the default of which is 160 pixels)"
    type: number
  }

  dimension: row {
    description: "The dashboard row in which the dashboard tile is located"
    type: number
  }

  dimension: width {
    description: "The width of the dashboard tile, in units defined by tile_size (the default of which is 160 pixels)"
    type: number
  }

  measure: count {
    type: count
    drill_fields: [id, dashboard_element.id, dashboard_layout.id, row, column, height, width, created_date, deleted_date, user.id, user.name ]
  }
}
