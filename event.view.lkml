view: event {

  dimension: id {
    description: "The unique numeric identifier for each event"
    primary_key: yes
    type: number
  }

  dimension: category {
    description: "The high-level category associated with each event (ex: 'dashboard')"
    type: string
  }

  dimension_group: created {
    description: "The time (in UTC) an event was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: name {
    description: "The specific event that occured (ex: 'create dashboard')"
    type: string
  }

  dimension: user_id {
    description: "The unique numeric ID of the user who triggered the event"
    type: number
    hidden: yes
  }

  dimension: is_admin {
    description: "Is the user identified by user_id a looker admin?"
    type: yesno
  }

  dimension: is_api_call {
    description: "Was the event due to an api call?"
    type: yesno
  }

  dimension: is_looker_employee {
    description: "Is the user identified by user_id a looker employee?"
    type: yesno
  }

  dimension: sudo_user_id {
    description: "ID of 'actual' user impersonating user indicated by user_id"
    type: number
  }

  measure: count {
    description: "The number of events"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      user.last_name,
      user.first_name,
      user.id,
      event_attribute.count
    ]
  }
}
