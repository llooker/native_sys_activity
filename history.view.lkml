view: history {

  dimension: id {
    primary_key: yes
    description: "The link to this query on the Queries page. (Requires see_queries permission.)"
    type: number
    link: {
      label: "Show in Queries Page"
      url: "/admin/queries/{{value}}"
    }
  }

  dimension: runtime {
    label: "Runtime in Seconds"
    description: "The number of seconds a query took to run"
    type: number
    value_format: "0.###"
    sql:  {% if _dialect._name == 'mysql' %}
            CONVERT(${TABLE}.runtime USING utf8mb4)
          {% else %}
            ${TABLE}.runtime
          {% endif %} ;;
  }

  dimension: runtime_under_10s {
    hidden: yes
    description: "Did the query run in less than 10 seconds?"
    type: yesno
    sql: ${runtime} < 10 ;;
  }

  measure: queries_under_10s {
    description: "Count of queries that ran in less than 10 seconds"
    type: count
    filters: {
      field: runtime_under_10s
      value: "Yes"
    }
    drill_fields: [query_detail*]
  }

  dimension: runtime_tiers {
    label: "Runtime Tiers in Seconds"
    description: "The number of seconds a query took to run, tiered"
    type: tier
    tiers: [0,5,10,30,120,300]
    sql: ${runtime} ;;
    style: integer
  }

  dimension: runtime_tiers_1 {
    label: "Runtime Tiers in 1-Second Increments"
    description: "The number of seconds a query took to run in tiers of 1-second increments"
    type: tier
    tiers: [
      1,2,3,4,5,6,7,8,9,10,
      11,12,13,14,15,16,17,18,19,20,
      21,22,23,24,25,26,27,28,29,30,
      31,32,33,34,35,36,37,38,39,40,
      41,42,43,44,45,46,47,48,49,50,
      51,52,53,54,55,56,57,58,59,60,
      61,62,63,64,65,66,67,68,69,70,
      71,72,73,74,75,76,77,78,79,80,
      81,82,83,84,85,86,87,88,89,90,
      91,92,93,94,95,96,97,98,99,100,
      101,102,103,104,105,106,107,108,109,110,
      111,112,113,114,115,116,117,118,119,120
    ]
    sql: ${runtime} ;;
    style: relational
  }

  dimension: runtime_tiers_5 {
    label: "Runtime Tiers in 5-Second Increments"
    description: "The number of seconds a query took to run in tiers of 5-second increments"
    type: tier
    tiers: [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120]
    sql: ${runtime} ;;
    style: integer
  }

  dimension: is_user_dashboard {
    description: "Is this query from a user-defined dashboard?"
    type: yesno
    sql: ${dashboard.id} IS NOT NULL ;;
  }

  dimension: raw_source {
    description: "The source of a query, such as a saved Look, dashboard, Explore, scheduled task, API, etc (raw values)"
    sql: ${TABLE}.SOURCE ;;
    hidden: yes
  }

  dimension: source {
    description: "The source of a query, such as a saved Look, Explore, scheduled task, API, etc"
    sql: ${TABLE}.SOURCE ;;
    # case: {
    #   when: {
    #     sql: ${raw_source} = 'alerts' ;;
    #     label: "Alert"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'api3' ;;
    #     label: "API 3"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'data-download-api' ;;
    #     label: "CSV Dashboard Download"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'dashboard' or ${raw_source} = 'run_async' ;;
    #     label: "Dashboard"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'dashboard_prefetch' ;;
    #     label: "Dashboard Prefetch"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'drill_modal' ;;
    #     label: "Drill Modal"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'explore' ;;
    #     label: "Explore"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'merge_query' ;;
    #     label: "Merge Query"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'regenerator' ;;
    #     label: "PDT Regenerator"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'private_embed' or ${raw_source} = 'private_url' ;;
    #     label: "Private Embed"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'public_embed' or ${raw_source} = 'public_url' ;;
    #     label: "Public Embed"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'scheduled_task' ;;
    #     label: "Scheduled Task"
    #   }
    #   when: {
    #     sql: ${raw_source} like 'look%' ;;
    #     label: "Saved Look"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'sqlrunner' ;;
    #     label: "SQL Runner"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'suggest' ;;
    #     label: "Suggest Filter"
    #   }
    #   when: {
    #     sql: ${raw_source} = 'query' ;;
    #     label: "Query"
    #   }
    #   when: {
    #     sql: ${raw_source} like 'render_manager%' ;;
    #     label: "Renderer"
    #   }
    #   else: "Other"
    # }
    alpha_sort: yes
  }

  dimension: issuer_source {
    description: "The source of a query, bucketed. Buckets are the API, users themselves, or automated system activities (PDTs & schedules)."
    case: {
      when: {
        sql: ${raw_source} = 'api3'
          OR ${raw_source} = 'dashboard_prefetch'
          OR ${raw_source} = 'data-download-api'
        ;;
        label: "API"
      }
      when: {
        sql: ${raw_source} = 'regenerator'
          OR ${raw_source} = 'scheduled_task'
          OR ${raw_source} = 'alerts'
        ;;
        label: "System"
      }
      when: {
        sql: ${raw_source} = 'dashboard'
          OR ${raw_source} = 'run_async'
          OR ${raw_source} = 'explore'
          OR ${raw_source} = 'private_embed'
          OR ${raw_source} = 'private_url'
          OR ${raw_source} = 'public_embed'
          OR ${raw_source} = 'public_url'
          OR ${raw_source} = 'public_embed'
          OR ${raw_source} like 'look%'
          OR ${raw_source} like 'render_manager%'
          OR ${raw_source} = 'source_query'
          OR ${raw_source} = 'sqlrunner'
          OR ${raw_source} = 'suggest'
          OR ${raw_source} = 'query'
          OR ${raw_source} = 'merge_query'
          OR ${raw_source} = 'drill_modal'
        ;;
        label: "User"
      }
      else: "Other"
    }
    alpha_sort: yes
  }

  dimension: most_recent_length {
    label: "Most Recent Run Length in Seconds"
    description: "The number of seconds a query took to run the last time it ran"
    type: number
    sql:
      (SELECT max_created.runtime
        FROM (SELECT h.query_id AS query_id, MAX(runtime) AS runtime
              FROM history h,
                  (SELECT query_id
                  ,MAX(created_at) as max_created
                  from history
                  group by query_id) as hi
              where h.query_id = hi.query_id and h.created_at = hi.max_created
              and runtime is not null
              group by h.query_id) as max_created
        WHERE ${TABLE}.query_id = max_created.query_id) ;;
    value_format: "0.###"
  }

  dimension_group: most_recent_run_at {
    label: "Most Recent Query Run at"
    description: "The last time an event in 'History' was created for a query"
    type: time
    sql:
      (SELECT max_created
      FROM
        (SELECT query_id
        ,MAX(created_at) as max_created
        from history
        group by query_id) as hi
      where ${TABLE}.query_id = hi.query_id) ;;
  }

  measure: query_run_count {
    label: "Query Run Count"
    description: "The number of query runs (this field is best used in conjunction with a filter or pivot on history source)"
    type: count
    drill_fields: [query_detail*]
  }

  measure: cache_result_query_count {
    label: "Results from Cache"
    description: "The number of queries returned from cache"
    type: count
    filters: {
      field: result_source
      value: "cache"
    }
    drill_fields: [query_detail*]
  }

  measure: database_result_query_count {
    label: "Results from Database"
    description: "The number of queries returned from database (as opposed to from cache)"
    type: count
    filters: {
      field: result_source
      value: "query"
    }
    drill_fields: [query_detail*]
  }

  measure: stale_cache_result_query_count {
    label: "Results from Stale Cache"
    description: "The number of queries returned from stale cache. This will only occur if instant dashboards are enabled."
    type: count
    filters: {
      field: result_source
      value: "stale_cache"
    }
    drill_fields: [query_detail*]
  }

  dimension: real_dash_id {
    view_label: "Dashboard"
    label: "ID (Inclusive)"
    description: "The unique string identifier for either a user-defined or a LookML dashboard"
    type: string
    sql:
      {% if _dialect._name == 'hypersql' %}
        COALESCE(${dashboard_id}, CONVERT(${dashboard.id}, SQL_VARCHAR))
      {% elsif _dialect._name == 'bigquery_standard_sql' %}
        COALESCE(${dashboard_id}, CAST(${dashboard.id} AS STRING))
      {% else %}
        COALESCE(${dashboard_id}, CAST(${dashboard.id} AS CHAR(256)))
      {% endif %};;
  }

  measure: first_query_date {
    description: "The first history event for a query"
    type: date
    sql: MIN(${created_raw}) ;;
    drill_fields: [query_detail*]
  }

  measure: most_recent_query_date {
    description: "The most recent history event for a query. This may be more recent than a user's Last UI Login if the query was run via the API, as part of a scheduled job, when sudoed, or during an embed session"
    type: date
    sql: MAX(${created_raw}) ;;
    drill_fields: [query_detail*]
  }

  measure: total_runtime {
    label: "Total Runtime in Seconds"
    description: "The sum of query run times in seconds"
    type: sum
    sql: ${runtime} ;;
    value_format_name: decimal_3
    drill_fields: [query_detail*]
  }

  measure: max_runtime {
    label: "Max Runtime in Seconds"
    description: "The longest query run time in seconds"
    type: max
    sql: ${runtime} ;;
    value_format_name: decimal_3
    drill_fields: [query_detail*]
  }

  measure: min_runtime {
    label: "Min Runtime in Seconds"
    description: "The shortest query run time in seconds"
    type: min
    sql: ${runtime} ;;
    value_format_name: decimal_3
    drill_fields: [query_detail*]
  }

  measure: average_runtime {
    label: "Average Runtime in Seconds"
    description: "The average query run time in seconds"
    type: average
    sql: NULLIF(${runtime},0) ;;
    value_format_name: decimal_3
    drill_fields: [query_detail*]
  }

  measure: approximate_usage_in_minutes {
    label: "Approximate Web Usage in Minutes"
    description: "An approximation of the number of minutes that a user used the Looker platform. This is estimated from their query usage data"
    type: number
    sql:
      {% if _dialect._name == 'bigquery_standard_sql' %}
       COUNT(DISTINCT
           CASE WHEN ${TABLE}.source NOT IN ('alerts', 'scheduled_task') THEN
             CONCAT(
              CAST(${TABLE}.user_id as STRING),
              CAST(FLOOR(UNIX_SECONDS(${TABLE}.created_at)/(60*5)) as STRING)
           )
           ELSE NULL
           END
         )*5
      {% else %}
        COUNT(DISTINCT
          CASE WHEN ${TABLE}.source NOT IN ('alerts', 'scheduled_task') THEN
            CONCAT(
             CAST(${TABLE}.user_id as CHAR(30)),
             FLOOR(UNIX_TIMESTAMP(${TABLE}.created_at)/(60*5))
          )
          ELSE NULL
          END
        )*5
      {% endif %};;
  }

  dimension: apply_formatting {
    description: "Was formatting applied to the data in the data download?"
    type: yesno
    hidden: yes
  }

  dimension: apply_vis {
    description: "Were the visualization options applied to the data download?"
    type: yesno
    hidden: yes
  }

  dimension: cache {
    description: "When this is true, Looker will attempt to pull results from cache for the query. Generally this will be true unless \"Clear Cache & Refresh\" was selected or the query originated from a Dashboard with Auto-Refresh enabled"
    type: yesno
  }

  dimension: cache_key {
    description: "The unique string identifier for a SQL-based cache entry"
    type: string
  }

  dimension: cache_only {
    label: "Is From Instant Dashboard"
    description: "When this is true, Looker will allow expired cache to be returned temporarily while fresh data is loaded in the background"
    type: yesno
  }

  dimension_group: completed {
    description: "When an event in 'History' was completed. Each event is linked to a query in Looker."
    type: time
    sql:
      {% if _dialect._name == 'bigquery_standard_sql' %}
        ${TABLE}.COMPLETED_AT_TIMESTAMP
      {% else %}
        ${TABLE}.COMPLETED_AT
      {% endif %};;
  }

  dimension: connection_id {
    description: "The unique string identifier for a connection"
    type: string
  }

  dimension: connection_name {
    description: "The name of the connection used to run the query"
    type: string
  }

  dimension_group: created {
    description: "When an event in 'History' was created. Each event is linked to a query in Looker."
    type: time
    sql: {% if _dialect._name == 'mysql' %}
            CONVERT(${TABLE}.CREATED_AT USING utf8mb4)
          {% else %}
            ${TABLE}.CREATED_AT
          {% endif %} ;;
  }

  dimension: dashboard_id {
    type: string
    hidden: yes
  }

  dimension: dashboard_id_as_number {
    hidden: yes
    type: number
    sql:
      {% if _dialect._name == 'hypersql' %}
        CASE WHEN REGEXP_MATCHES (${dashboard_id}, '^[0-9]+$')
          THEN CAST(${dashboard_id} AS INTEGER)
          ELSE 0
          END
      {% elsif _dialect._name == 'bigquery_standard_sql' %}
        CASE WHEN REGEXP_CONTAINS (${dashboard_id}, '^[0-9]+$')
          THEN CAST(${dashboard_id} AS INT64)
          ELSE 0
          END
      {% else %}
        CAST(${dashboard_id} AS SIGNED)
      {% endif %}
    ;;
  }

  dimension: dashboard_session {
    description: "The unique numeric identifier for a single time the dashboard was loaded"
    type: string
  }

  dimension: dialect {
    description: "The database dialect used to run the query"
    type: string
  }

  dimension: force_production {
    description: "Was the query forced to run against production regardless of whether the user was in dev mode? An example of Looker adding this flag is when running scheduled jobs."
    type: yesno
  }

  dimension: generate_links {
    description: "Were links (such as drill links) generated in the query results?"
    type: yesno
  }

  dimension: look_id {
    type: number
    hidden: yes
  }

  dimension: message {
    description: "General information about the query, often around error reporting or the current status"
    type: string
  }

  dimension: node_id {
    type: number
    hidden: yes
  }

  dimension: query_id {
    type: number
    hidden: yes
  }

  dimension: rebuild_pdts {
    label: "Rebuild PDTs"
    description: "Did the user request for derived tables to be rebuilt when they initiated the query?"
    type: yesno
  }

  dimension: render_key {
    description: "The unique string cache key for the fully formatted results cache"
    type: string
  }

  dimension: result_format {
    description: "The export format chosen for non-image result sets"
    type: string
  }

  dimension: result_maker_id {
    hidden: yes
  }

  dimension: is_single_query {
    description: "Whether the event in 'History' represents a single query or a merge query. Running a merge query creates a history event for the merge query itself, in addition to the events created for the individual queries."
    type: yesno
    sql: ${query_id} IS NOT NULL  ;;
  }

  dimension: result_source {
    description: "Whether the result set of a query was returned from cache or from database"
    type: string
  }

  dimension: server_table_calcs {
    description: "Were table calculations computed by the server (as opposed to the browser)?"
    type: yesno
  }

  dimension: slug {
    description: "The unique string identifier for a query"
    type: string
  }

  dimension: sql_query_id {
    description: "The SQL Runner query ID"
    type: number
    hidden: yes
  }

  dimension: status {
    description: "The current status of the history event. For more information about errors, see the 'message' field. 'cache_only_miss' is a result when a query is run with the 'cache_only=TRUE' option and the cache entry is not present."
    type: string
  }

  dimension: title {
    type: string
    hidden: yes
  }

  dimension: user_id {
    type: number
    hidden: yes
  }

  dimension: workspace_id {
    description: "The environment in which the history event was intiated. Values are production, dev, and null."
    type: string
  }

  measure: count {
    type: count
    drill_fields: [query_detail*]
  }

  measure: explore_user {
    description: "The count of distinct users that have run Explore queries"
    type: count_distinct
    sql:
      CASE WHEN ${source} = 'explore'
      THEN ${user.id}
      ELSE NULL
      END ;;
    drill_fields: [user.user_detail*]
  }

  measure: dashboard_user {
    description: "The count of distinct users that have run dashboard queries"
    type: count_distinct
    sql:
      CASE WHEN ${source} = 'dashboard' or ${source} = 'run_async'
      THEN ${user.id}
      ELSE NULL
      END ;;
    drill_fields: [user.user_detail*]
  }

  measure: sql_runner_user {
    label: "SQL Runner User"
    description: "The count of distinct users that have run SQL Runner queries"
    type: count_distinct
    sql:
      CASE WHEN ${source} = 'sqlrunner'
      THEN ${user.id}
      ELSE NULL
      END ;;
    drill_fields: [user.user_detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      source,
      connection_name,
      created_time,
      user.id,
      query.id,
      sql_query.id,
    ]
  }

  set: query_detail{
    fields: [
      query.id,
      query.model,
      query.view,
      sql_query.id,
      history.source,
      history.created_time,
      history.runtime,
      history.connection_name,
      user.id,
      user.name
    ]
  }

  set: drill_for_dash {
    fields: [
      history.id,
      history.created_time,
      user.name,
      query.model,
      query.view,
      history.source,
      query.formatted_fields,
      query.formatted_pivots,
      query.formatted_filters,
      query.limit,
      history.runtime
    ]
  }
}

view: filtered_history_users_last_30days {
  derived_table: {
    explore_source: history {
      column: user_id    { field: history.user_id }
      filters: {
        field: history.completed_time
        value: "last 30 days"
      }
    }
  }

  dimension: user_id {
    hidden: yes
    type: number
    primary_key: yes
  }

  measure: users_30_days {
    view_label: "History"
    description: "The count of distinct users that have run completed queries in the last 30 days"
    type: count
    drill_fields: [user.user_detail*]
  }
}

view: filtered_history_users_last_7days {
  derived_table: {
    explore_source: history {
      column: user_id    { field: history.user_id }
      filters: {
        field: history.completed_time
        value: "last 7 days"
      }
    }
  }

  dimension: user_id {
    hidden: yes
    type: number
    primary_key: yes
  }

  measure: users_7_days {
    view_label: "History"
    description: "The count of distinct users that have run completed queries in the last 7 days"
    type: count
    drill_fields: [user.user_detail*]
  }
}

view: filtered_history_dashboards {
  derived_table: {
    explore_source: history {
      column: dashboard_id    { field: history.dashboard_id }
      filters: {
        field: history.created_time
        value: "last 30 days"
      }
    }
  }

  dimension: dashboard_id {
    hidden: yes
    type: string
    primary_key: yes
  }

  dimension: dashboard_id_as_number {
    hidden: yes
    type: number
    sql:
      {% if _dialect._name == 'hypersql' %}
        CASE WHEN REGEXP_MATCHES (${dashboard_id}, '^[0-9]+$')
          THEN CAST(${dashboard_id} AS INTEGER)
          ELSE 0
          END
      {% elsif _dialect._name == 'bigquery_standard_sql' %}
        CASE WHEN REGEXP_CONTAINS (${dashboard_id}, '^[0-9]+$')
          THEN CAST(${dashboard_id} AS INT64)
          ELSE 0
          END
      {% else %}
        CAST(${dashboard_id} AS SIGNED)
      {% endif %}
    ;;
  }

  measure: dashboards_used_last_30 {
    view_label: "Dashboard"
    description: "The number of distinct dashboards with a completed query in the last 30 days"
    type: count
    drill_fields: [dashboard.dashboard_detail*]
  }
}

view: filtered_history_looks {
  derived_table: {
    explore_source: history {
      column: look_id    { field: history.look_id }
      filters: {
        field: history.created_time
        value: "last 30 days"
      }
    }
  }

  dimension: look_id {
    hidden: yes
    type: number
    primary_key: yes
  }

  measure: looks_used_last_30 {
    view_label: "Look"
    description: "The number of distinct Looks with a completed query in the last 30 days"
    type: count
    drill_fields: [look.look_detail*]
  }
}
