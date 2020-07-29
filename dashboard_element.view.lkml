view: dashboard_element {

  dimension: id {
    description: "The unique numeric identifier for a dashboard tile"
    primary_key: yes
    type: number
  }

  dimension: body_text {
    description: "The body text of a text tile"
    type: string
  }

  dimension_group: created {
    description: "When the dashboard tile was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: dashboard_id {
    type: number
    hidden: yes
  }

  dimension_group: deleted {
    description: "When the dashboard tile was deleted. If the tile has never been deleted, the value of this field is null."
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: listen {
    description: "The dashboard filters the element listens to"
    type: string
  }

  dimension: look_id {
    type: number
    hidden: yes
  }

  dimension: note_display {
    description: "The location of a note on the dashboard tile"
    type: string
  }

  dimension: note_state {
    description: "Whether a dashboard note is expanded. A note that is not expanded shows in the middle of the tile and shows only the beginning of the text with an icon to expand. An expanded note shows in entirety and is left-justified in the tile."
    type: string
  }

  dimension: note_text {
    description: "The note text shown on the dashboard tile"
    type: string
  }

  dimension: query_id {
    type: number
    hidden: yes
  }

  dimension: coalesced_query_id {
    type: number
    hidden: yes
    required_fields: [look.query_id, merge_query_source_query.query_id]
    sql: COALESCE(${query_id}, ${look.query_id}, ${merge_query_source_query.query_id}) ;;
  }

  dimension: refresh_interval {
    description: "The frequency with which the dashboard will refresh if auto-refresh is enabled. If auto-refresh is disabled, the value of this field is null."
    type: string
  }

  dimension: result_maker_id {
    type: number
    hidden: yes
  }

  dimension: result_source {
    description: "The type of dashboard element. Values are 'Saved Look', 'Lookless', or 'Merge Query'."
    type: string
    case: {
      when: {
        sql: ${look_id} IS NOT NULL ;;
        label: "Saved Look"
      }
      when: {
        sql: ${query_id} IS NOT NULL ;;
        label: "Lookless"
      }
      # NOTE: Order matters here.
      #       The following case depends on the first two cases failing.
      when: {
        sql: ${result_maker_id} IS NOT NULL ;;
        label: "Merge Query"
      }
      else: "No Result"
    }
  }

  dimension: subtitle_text {
    description: "The subtitle of a text tile"
    type: string
  }

  dimension: title {
    description: "The title of a dashboard tile"
    type: string
  }

  dimension: title_hidden {
    description: "Is the dashboard tile's title shown?"
    type: yesno
  }

  dimension: title_text {
    description: "The title of a text tile"
    type: string
  }

  dimension: type {
    description: "The type of dashboard tile: data, visualization, or text"
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_look {
    description: "The number of dashboard tiles that are Look-based"
    type: count
    filters: {
      field: result_source
      value: "Saved Look"
    }
    drill_fields: [detail*]
  }

  measure: count_lookless {
    description: "The number of Lookless dashboard tiles"
    type: count
    filters: {
      field: result_source
      value: "Lookless"
    }
    drill_fields: [detail*]
  }

  measure: count_merge_query {
    description: "The number of merge query tiles"
    type: count
    filters: {
      field: result_source
      value: "Merge Query"
    }
    drill_fields: [detail*]
  }

  measure: count_text {
    description: "The number of text tiles"
    type: count
    filters: {
      field: type
      value: "text"
    }
    drill_fields: [id, title_text, subtitle_text, body_text]
  }

  measure: count_last_30_days {
    description: "The number of dashboard elements created in the last 30 days"
    type: count
    filters: {
      field: created_date
      value: "last 30 days"
    }
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      query.id,
      look.id,
      dashboard.id,
      created_date,
      deleted_date,
      title,
      type,
      result_source
    ]
  }
}
