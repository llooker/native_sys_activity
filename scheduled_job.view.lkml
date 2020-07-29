view: scheduled_job {

  dimension: id {
    primary_key: yes
    description: "The unique numeric identfier for the scheduled job"
    type: number
  }

  dimension_group: created {
    description: "When a scheduled job was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: cron_schedule {
    description: "The cron string that defines a job's delivery schedule"
    type: string
    sql: ${TABLE}.CRONTAB ;;
  }

# commenting this out re: https://github.com/looker/helltool/issues/41579
#  dimension: dashboard_filters {
#    type: string
#  }

  dimension: dashboard_id {
    description: "The unique numeric identifier for the dashboard associated with the scheduled job"
    type: number
    # hidden: yes
  }

  dimension: datagroup {
    description: "The name of the datagroup used to trigger the scheduled job"
    type: string
  }

  dimension: filters_string {
    description: "The URL-encoded filter string that is appended to the source content URL"
    type: string
  }

  dimension_group: finalized {
    description: "When a scheduled job ended, regardless of success or failure. See the 'Status' field for job status."
    type: time
    sql: ${TABLE}.FINALIZED_AT ;;
  }

  dimension: include_links {
    description: "Was the link to the content source in Looker included in the delivery?"
    type: yesno
  }

  dimension: look_id {
    description: "The unique numeric identifier for the Look that is associated with the scheduled job"
    type: number
    # hidden: yes
  }

  dimension: lookml_dashboard_id {
    description: "The unique string identifier for the LookML dashboard associated with the scheduled job"
    type: string
  }

  dimension: name {
    description: "The name of the scheduled job"
    type: string
  }

  dimension: query_id {
    description: "The unique numeric identifier for a query associated with the scheduled job"
    type: number
    # hidden: yes
  }

  dimension: require_change {
    description: "Did the scheduled job send only if results had changed since the query's last run?"
    type: yesno
  }

  dimension: require_no_results {
    description: "Did the scheduled job send only if there were no results?"
    type: yesno
  }

  dimension: require_results {
    description: "Did the scheduled job send only if there were results?"
    type: yesno
  }

  dimension: row_limit_reached {
    description: "Did the scheduled job reach the query row limit?"
    type: yesno
  }

  dimension: run_as_recipient {
    description: "Did the scheduled job run the query as the recipient?"
    type: yesno
  }

  dimension: run_once {
    description: "Was this delivery triggered using the \"Send\" or \"Send Test\" option?"
    type: yesno
  }

  dimension: scheduled_plan_id {
    description: "The unique numeric identfier for a scheduled plan"
    type: number
    # hidden: yes
  }

  dimension: send_all_results {
    description: "Did the scheduled job send all results with no limit?"
    type: yesno
  }

  dimension: status {
    description: "The status of the scheduled job. Can be success, failure, in progress, or disabled."
    type: string
  }

  dimension: status_detail {
    description: "Detailed information about the status of the scheduled job"
    type: string
  }

  dimension: timezone {
    description: "The timezone specified for the scheduled job's delivery time"
    type: string
  }

  dimension: user_id {
    description: "The unique numeric identifier of the user who owns the scheduled plan"
    type: number
    # hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [user.name, user.email, scheduled_job.count]
  }

  # ----- Sets of fields for drilling ------
  set: scheduled_job_detail {
    fields: [
      id,
      created_time,
      datagroup,
      status,
      look_id,
      dashboard_id,
      lookml_dashboard_id,
      scheduled_plan.name,
      scheduled_job_destination.count,
      user.last_name,
      user.first_name
    ]
  }
}

# this view does not seem to be joined anywhere so not adding descriptions
view: scheduled_job_most_recent {
  derived_table: {
    sql:
      SELECT
        created_at,
        scheduled_plan_id,
        data_signature,
        data_slug,
        finalized_at,
        status,
        status_detail
      FROM scheduled_job sj
      WHERE created_at =
        (
          SELECT
            MAX(created_at)
          FROM scheduled_job sj2
          WHERE sj.scheduled_plan_id=sj2.scheduled_plan_id
          GROUP BY scheduled_plan_id
        )
      ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created_at;;
  }

  dimension: scheduled_plan_id {
    type: number
    # hidden: true
  }

  dimension: data_signature {
    type: string
  }

  dimension: data_slug {
    type: string
  }

  dimension_group: finalized {
    type: time
    sql: ${TABLE}.finalized_at;;
  }

  dimension: status {
    type: string
  }

  dimension: status_detail {
    type: string
  }
}
