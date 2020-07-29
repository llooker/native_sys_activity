view: scheduled_job_destination {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: address {
    type: string
  }

  dimension: apply_formatting {
    type: yesno
  }

  dimension: apply_vis {
    type: yesno
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: format {
    type: string
  }

  dimension: message {
    type: string
  }

  dimension: scheduled_job_id {
    type: number
    # hidden: yes
  }

  dimension: scheduled_plan_destination_id {
    type: number
    # hidden: yes
  }

  dimension: slug {
    type: string
  }

  dimension: type {
    type: string
  }

  measure: count {
    type: count
    drill_fields: [id, scheduled_job.name, scheduled_job.id, scheduled_plan_destination.id]
  }
}
