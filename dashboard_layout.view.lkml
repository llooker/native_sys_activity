view: dashboard_layout {

  dimension: id {
    description: "The unique numeric identifier for the dashboard"
    primary_key: yes
    type: number
  }

  dimension: active {
    description: "Is this dashboard layout active? A dashboard can have multiple layouts, but only one can be active at any time."
    type: yesno
  }

  dimension: column_width {
    description: "For dashboard with layout:tile, the width in pixels of the tile columns. For other dashboard types, the value of this field is null."
    type: number
  }

  dimension_group: created {
    description: "When the dashboard was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: dashboard_id {
    type: number
    hidden: yes
  }

  dimension_group: deleted {
    description: "When the dashboard was deleted. If the dashboard has not been deleted, the value of this field is null."
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: type {
    description: "The layout method used for the dashboard drag, newspaper, or tile"
    type: string
  }

  dimension: width {
    description: "For dashboards of layout type:tile, the width in pixels of the dashboard. For other dashboard types, the value of this field is null."
    type: number
  }

  measure: count {
    type: count
    drill_fields: [id, dashboard.id, dashboard_layout_component.count, created_date, user.id, user.name]
  }
}
