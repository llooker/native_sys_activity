view: content_metadata {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: content_id {
    type: number
  }

  dimension: content_type {
    type: string
  }

  dimension: dashboard_id {
    type: number
    # hidden: yes
  }

  dimension_group: deleted {
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: description {
    type: string
  }

  dimension: inheriting_id {
    type: number
  }

  dimension: look_id {
    type: number
    # hidden: yes
  }

  dimension: parent_id {
    type: number
  }

  dimension: space_id {
    type: number
    # hidden: yes
  }

  dimension: title {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      folders.name,
      folders.id,
      dashboard.id,
      look.id,
      content_favorite.count,
      content_metadata_group_user.count,
      dashboard.count,
      look.count,
      folders.count
    ]
  }
}