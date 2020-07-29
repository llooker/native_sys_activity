view: look {

  dimension: id {
    primary_key: yes
    description: "The unique numeric identifier for the Look"
    type: number
  }

  dimension: content_metadata_id {
    type: number
    hidden: yes
  }

  dimension_group: created {
    description: "When the Look was initially created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension_group: deleted {
    description: "When the Look was deleted. If the Look has not been deleted, this field will be null."
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: deleter_id {
    description: "The unique numeric ID of the user who deleted the Look. If the Look has not been deleted, this field will be null."
    type: number
  }

  dimension: description {
    description: "The description assigned to the Look"
    type: string
  }

  dimension: is_run_on_load {
    description: "Is the Look configured to automatically download data when it is opened?"
    type: yesno
  }

  dimension: last_updater_id {
    description: "The unique numeric ID of the user who most recently updated the Look or its underlying query"
    type: number
  }

  dimension: public {
    description: "Has public access been enabled for the Look?"
    type: yesno
  }

  dimension: public_slug {
    description: "The Look's unique string ID, included in the public URL"
    type: string
  }

  dimension: query_id {
    type: number
    hidden: yes
  }

  dimension: space_id {
    type: number
    hidden: yes
  }

  dimension: title {
    description: "The Look's title"
    type: string
    html: <a href="/looks/{{ id._value }}">{{value}}</a> ;;
  }

  dimension: link {
    description: "A clickable link to the Look's URL"
    sql: ${id} ;;
    html: [<a href="/looks/{{ value }}">Look</a>] ;;
  }

  dimension: public_embed_link {
    description: "A clickable link to the URL where the Look is embedded and publicly accessible"
    sql: ${public_slug} ;;
    html: <a href="/embed/public/{{ value }}" target="_blank">[Public Embed Link]</a> ;;
  }

  dimension_group: updated {
    description: "When the Look or its underlying query was updated"
    type: time
    sql: ${TABLE}.UPDATED_AT ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [look_detail*]
  }

  measure: count_last_30_days {
    description: "Looks created in the last 30 days"
    type: count
    filters: {
      field: created_date
      value: "last 30 days"
    }
    drill_fields: [look_detail*]
  }


  # ----- Sets of fields for drilling ------
  set: look_detail {
    fields: [
      id,
      title,
      created_date,
      deleted_date,
      link,
      folders.name,
      user.id,
      user.name,
      content_favorite.count,
      dashboard_element.count,
      history.count,
      scheduled_plan.count,
    ]
  }
}