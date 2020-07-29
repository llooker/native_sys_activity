view: scheduled_plan_destination {

  dimension: id {
    primary_key: yes
    description: "The unique numeric identifier for the scheduled plan-destination-save combination. If the destination field is edited, all addresses get a new ID."
    type: number
  }

  dimension: address {
    description: "A destination address for the scheduled plan"
    type: string
  }

  dimension: apply_formatting {
    description: "Are values displayed using the formatting set in Looker?"
    type: yesno
  }

  dimension: apply_vis {
    description: "Are settings from the Plot, Series, and Formatting menus applied to the scheduled plan?"
    type: yesno
  }

  dimension_group: created {
    description: "When the scheduled plan's destination field was last updated"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: format {
    description: "The export format set in the scheduled plan"
    type: string
  }

  dimension: message {
    description: "Optional custom message text to append to the scheduled email"
    type: string
  }

  dimension: parameters {
    description: "Conditions that determine whether the schedule should be sent"
    type: string
  }

  dimension: s3_region {
    description: "Amazon Web Services region for Amazon S3 destinations"
    type: string
  }

  dimension: scheduled_plan_id {
    description: "The unique numeric identifier for a scheduled plan"
    type: number
    hidden: yes
  }

  dimension: slug {
    hidden: yes
    type: string
  }

  dimension: type {
    description: "The delivery method set in the scheduled plan"
    type: string
  }

  measure: count {
    type: count
    drill_fields: [id, scheduled_plan.name, scheduled_plan.id, scheduled_job_destination.count]
  }
}
