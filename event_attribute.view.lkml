view: event_attribute {

  dimension: id {
    description: "The unique numeric identifier for each change that occured due to a triggered event. One event may have multiple event_attribute rows associated with it."
    primary_key: yes
    type: number
  }

  dimension: event_id {
    description: "The unique numeric ID of the triggered event"
    type: number
    hidden: yes
  }

  dimension: name {
    description: "The name of the attribute involved in the event (ex: 'dashboard_id'). Can be used in combination with 'event_attribute.value' to find details of a specific event."
    type: string
  }

  dimension: value {
    description: "The value of the attribute involved in the event"
    type: string
  }

  measure: count {
    description: "The number of event attributes"
    type: count
    drill_fields: [id, name, event.id, event.name]
  }
}
