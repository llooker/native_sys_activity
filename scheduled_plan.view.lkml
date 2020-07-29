view: scheduled_plan {

  dimension: id {
    primary_key: yes
    description: "The unique numeric identfier for a scheduled plan"
    type: number
    link: {
      label: "Show in Admin"
      url: "/admin/scheduled_jobs?scheduled_plan_id={{value}}"
    }
  }

  dimension_group: created {
    description: "When a scheduled plan was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: cron_schedule {
    description: "The cron string that defines a schedule's time of delivery"
    type: string
    sql: ${TABLE}.CRONTAB ;;
  }

# commenting this out re: https://github.com/looker/helltool/issues/41579
#   dimension: dashboard_filters {
#     type: string
#   }

  dimension: dashboard_id {
    description: "The unique numeric identifier of the dashboard associated with the scheduled plan"
    type: number
    # hidden: yes
  }

  dimension: datagroup {
    description: "The name of the datagroup used to trigger the schedule"
    type: string
  }

  dimension: enabled {
    description: "Is the scheduled plan enabled? If not, it will not send."
    type: yesno
  }

  dimension: filters_string {
    description: "The URL-encoded filter string that is appended to source content URL"
    type: string
  }

  dimension: include_links {
    description: "Is the link to the content source in Looker included in the delivery?"
    type: yesno
  }

  dimension: look_id {
    description: "The unique numeric identifier of the Look that is associated with the scheduled plan"
    type: number
    # hidden: yes
  }

  dimension: lookml_dashboard_id {
    description: "The unique string identifier of the LookML dashboard associated with the scheduled plan"
    type: string
  }

  dimension: lookml_dashboard_link {
    description: "Link to the LookML dashboard associated with the scheduled plan"
    type: string
    sql: ${lookml_dashboard_id} ;;
    html: [<a href="/dashboards/{{ value }}">Dashboard</a>] ;;
  }

  dimension: name {
    description: "The name of the scheduled plan"
    type: string
  }

  dimension_group: next_run {
    description: "The next scheduled delivery"
    alias: [scheduled_plan.next_run_at]
    type: time
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            CAST(${TABLE}.NEXT_RUN_AT AS INT64)
          {% else %}
            FLOOR(${TABLE}.NEXT_RUN_AT)
          {% endif %} ;;
    datatype: epoch
  }

  dimension: query_id {
    description: "The query's unique numeric ID"
    type: number
    # hidden: yes
  }

  dimension: require_change {
    description: "Will the schedule send only if results have changed since the query's last run?"
    type: yesno
  }

  dimension: require_no_results {
    description: "Will the schedule send only if there are no results?"
    type: yesno
  }

  dimension: require_results {
    description: "Will the schedule send only if there are results?"
    type: yesno
  }

  dimension: run_as_recipient {
    description: "Will the schedule run the query as the recipient?"
    type: yesno
  }

  dimension: run_once {
    description: "Was this delivery triggered using the \"Send\" or \"Send Test\" option?"
    type: yesno
  }

  dimension: send_all_results {
    description: "Does the schedule send all results with no limit?"
    type: yesno
  }

  dimension: requirements {
    description: "Query requirements for the schedule to send"
    sql:
      CASE
        WHEN ${require_results} AND NOT ${require_change} THEN 'Send if query has results'
        WHEN ${require_results} AND ${require_change} THEN 'Send if query has results AND results have changed'
        WHEN ${require_change} AND NOT ${require_results} THEN 'Send if query results have changed - includes empty result sets'
        WHEN ${require_no_results} THEN 'Send if Query has No Results'
      ELSE 'Always Send'
      END ;;
  }

  dimension: content_link {
    description: "A clickable link to the scheduled plan's source content"
    sql: ${id} ;;
    html:
      {% if scheduled_plan.look_id._value != nil %}
        [<a href="/looks/{{ scheduled_plan.look_id._value }}">Look</a>]
      {% elsif scheduled_plan.dashboard_id._value != nil %}
        [<a href="/dashboards/{{ scheduled_plan.dashboard_id._value }}">Dashboard</a>]
      {% elsif scheduled_plan.lookml_dashboard_id._value != nil %}
        [<a href="/dashboards/{{ scheduled_plan.lookml_dashboard_id._value }}">LookML Dashboard</a>]
      {% endif %} ;;
  }

  dimension: content_type_id {
    description: "Content Type and ID"
    sql:
          CASE  WHEN ${dashboard_id} IS NULL THEN
              CASE  WHEN ${look_id} IS NULL THEN
                  CASE  WHEN ${lookml_dashboard_id} IS NULL THEN NULL
          {% if _dialect._name == 'bigquery_standard_sql' %}
                        ELSE CONCAT("LookML Dashboard ", ${lookml_dashboard_id})
                        END
                    ELSE CONCAT("Look ", CAST(${look_id} AS STRING))
                    END
                ELSE CONCAT("Dashboard ", CAST(${dashboard_id} AS STRING))
          {% elsif _dialect._name == 'mysql' %}
                        ELSE CONCAT("LookML Dashboard ", ${lookml_dashboard_id})
                        END
                    ELSE CONCAT("Look ", CAST(${look_id} AS CHAR))
                    END
                ELSE CONCAT("Dashboard ", CAST(${dashboard_id} AS CHAR))
          {% elsif _dialect._name == 'hypersql' %}
                        ELSE CONCAT('LookML Dashboard ', ${lookml_dashboard_id})
                        END
                    ELSE CONCAT('Look ', CAST(${look_id} AS varchar(50)))
                    END
                ELSE CONCAT('Dashboard ', CAST(${dashboard_id} AS varchar(50)))
          {% endif %}
                END
    ;;
    html:
    {% if scheduled_plan.look_id._value != nil %}
      [<a href="/looks/{{ scheduled_plan.look_id._value }}">{{value}}</a>]
    {% elsif scheduled_plan.dashboard_id._value != nil %}
      [<a href="/dashboards/{{ scheduled_plan.dashboard_id._value }}">{{value}}</a>]
    {% elsif scheduled_plan.lookml_dashboard_id._value != nil %}
      [<a href="/dashboards/{{ scheduled_plan.lookml_dashboard_id._value }}">{{value}}</a>]
    {% endif %} ;;
  }


  dimension: space_id {
    description: "The unique numeric identifier of the Space in which the scheduled plan's content is located"
    type: number
    sql: COALESCE(${look.space_id}, ${dashboard.space_id}) ;;
  }

  dimension: space_link {
    description: "A clickable link to the Space where the scheduled plan's content is located"
    sql: COALESCE(${look.space_id}, ${dashboard.space_id}, -1) ;;
    html:
      {% if value == -1 %}
        [<a href="/spaces/lookml">Space</a>]
      {% else %}
        [<a href="/spaces/{{ value }}/">Space</a>]
      {% endif %} ;;
  }

  dimension: timezone {
    description: "The timezone specified for the schedule's delivery time"
    type: string
  }

  dimension_group: updated {
    description: "The time of the most recent update or change to the scheduled plan"
    type: time
    sql: {% if _dialect._name == 'bigquery_standard_sql' %}
          TIMESTAMP_MICROS(${TABLE}.UPDATED_AT)
          {% else %}
          ${TABLE}.UPDATED_AT
          {% endif %} ;;
  }

  dimension: user_id {
    description: "The unique numeric identifier of the user who owns the scheduled plan"
    type: number
    # hidden: yes
  }

  measure: destination_addresses {
    description: "The list of all recipients' email addresses"
    sql:  {% if _dialect._name == 'hypersql' or _dialect._name == 'mysql' %}
            REPLACE(GROUP_CONCAT(DISTINCT ${scheduled_plan_destination.address}), ',', ', ')
          {% elsif _dialect._name == 'bigquery_standard_sql' %}
            REPLACE(STRING_AGG(DISTINCT ${scheduled_plan_destination.address}), ',', ', ')
          {% elsif _dialect._name == 'snowflake' %}
            REPLACE(LISTAGG(DISTINCT ${scheduled_plan_destination.address}), ',', ', ')
          {% endif %} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail* ]
  }

  measure: count_last_30_days {
    description: "Number of scheduled plans created in the last 30 days"
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
      name,
      created_date,
      user.name,
      scheduled_job.count,
      scheduled_plan_destination.count
    ]
  }
}

view: scheduled_job_frequency {
  derived_table: {
    sql: SELECT
        scheduled_job.CREATED_AT AS scheduled_job_created_time,
        scheduled_plan.id AS scheduled_plan_id,
         scheduled_job.id AS scheduled_job_id,
        LAG(scheduled_job.CREATED_AT) OVER (PARTITION BY scheduled_plan.id
              ORDER BY scheduled_job.id, scheduled_job.CREATED_AT) as previous_value,
        TIMESTAMP_DIFF(scheduled_job.CREATED_AT, LAG(scheduled_job.CREATED_AT) OVER (PARTITION BY scheduled_plan.id
              ORDER BY scheduled_job.id, scheduled_job.CREATED_AT), second) as frequency_in_seconds
      FROM scheduled_plan
      LEFT JOIN scheduled_job ON scheduled_job.scheduled_plan_id = scheduled_plan.id
      GROUP BY 1,2,3
       ;;
  }

  dimension: scheduled_plan_id {
    type: number
    hidden:  yes
    sql: ${TABLE}.scheduled_plan_id ;;
  }

  dimension: scheduled_job_id {
    type: number
    hidden:  yes
    sql: ${TABLE}.scheduled_job_id ;;
  }

  dimension_group: previous_value {
    type: time
    hidden:  yes
    sql: ${TABLE}.previous_value ;;
  }

  dimension: frequency_in_seconds {
    type: number
    sql: ${TABLE}.frequency_in_seconds ;;
  }

  measure: average_frequency_in_minutes {
    type: average
    sql: (${frequency_in_seconds}/60) ;;
    value_format_name: decimal_1
  }

  set: detail {
    fields: [scheduled_plan_id, scheduled_job_id, previous_value_time, frequency_in_seconds]
  }
}
