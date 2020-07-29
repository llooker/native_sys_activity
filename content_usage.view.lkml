view: content_usage {

  dimension: id {
    description: "The unique numeric identifier for the content"
    primary_key: yes
    type: number
  }

  dimension: api_count {
    description: "Number of times this content has been viewed via the Looker API"
    type: number
  }

  dimension: content_id {
    description: "Content ID will be Look ID, dashboard ID, or LookML dashboard ID"
    type: string
  }

  dimension: content_id_as_number {
    hidden: yes
    type: number
    sql:
      {% if _dialect._name == 'hypersql' %}
        CASE WHEN REGEXP_MATCHES (${content_id}, '^[0-9]+$')
          THEN CAST(${content_id} AS INTEGER)
        ELSE 0
        END
      {% elsif _dialect._name == 'bigquery_standard_sql' %}
        CASE WHEN REGEXP_CONTAINS (${content_id}, '^[0-9]+$')
          THEN CAST(${content_id} AS INT64)
        ELSE 0
        END
      {% else %}
        CAST(${content_id} AS SIGNED)
      {% endif %};;
  }

  dimension: content_type {
    description: "Whether the content is a Look, dashboard, or LookML dashboard"
    type: string
  }

  dimension: content_title {
    description: "The text of the Look or dashboard title"
    type: string
    sql: COALESCE(${look.title},${dashboard.title},${content_id}) ;;
    html: <a href="/{{content_type._value}}s/{% if content_type._value == 'look' %}{{look.id._value}}{% elsif content_id_as_number._value > 0 %}{{dashboard.id._value}}{% else %}{{content_id._value}}{% endif %}" rel="noopener">{{value}}</a> ;;
    required_fields: [dashboard.id, look.id]
  }

  dimension: embed_count {
    description: "The number of times this content has been viewed in an embedded setting"
    type: number
  }

  dimension: favorite_count {
    description: "The current favorite count for this content"
    type: number
  }

  dimension_group: last_accessed {
    description: "The date and time this content was last accessed. NOTE: Looks and Dashboards are treated as separate pieces of content. Viewing a look on a dashboard will not update this field."
    type: time
    sql: ${TABLE}.LAST_ACCESSED_AT ;;
  }

  dimension: days_since_last_accessed {
    description: "The number of days since this content was last accessed"
    type: number
    sql:
      {% if _dialect._name == 'bigquery_standard_sql' %}
        DATE_DIFF(CURRENT_DATE(), EXTRACT(DATE from ${last_accessed_raw}), DAY)
      {% else %}
        DATEDIFF(now(), ${last_accessed_raw})
      {% endif %};;
  }

  dimension: days_since_last_access_tiers {
    description: "The number of days since this content was last accessed, grouped into ranges of days"
    type: tier
    tiers: [0,7,14,30,60,90]
    sql: ${days_since_last_accessed} ;;
    style: integer
  }

  dimension: other_count {
    label: "View Count"
    description: "The number of times this content has been viewed from the Looker UI"
    type: number
  }

  dimension: prefetch_count {
    description: "The number of times this content has been prefetched to warm the cache before running a scheduled job"
    type: number
  }

  dimension: public_count {
    description: "The number of times this content has been viewed as public"
    type: number
  }

  dimension: schedule_count {
    description: "The number of scheduled jobs run for this content"
    type: number
  }

  measure: embed_total {
    description: "The total number of views in an embedded setting"
    type: sum
    sql: ${embed_count} ;;
  }

  measure: schedule_total {
    description: "The total number of scheduled jobs"
    type: sum
    sql: ${schedule_count} ;;
  }

  measure: favorites_total {
    description: "The total number of favorite counts"
    type: sum
    sql: ${favorite_count} ;;
  }

  measure: other_total {
    description: "The total number of views in the Looker UI"
    label: "View Total"
    type: sum
    sql: ${other_count} ;;
  }

  measure: api_total {
    description: "The total number of views via the Looker API"
    type: sum
    sql: ${api_count} ;;
  }

  measure: content_count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      content_type,
      content_id,
      last_accessed_time,
      prefetch_count,
      embed_count,
      schedule_count,
      public_count,
      api_count,
      other_count,
      favorite_count
    ]
  }
}

view: _dashboard_linked_looks {
  derived_table: {
    explore_source: dashboard {
      column: _id { field: look.id }
    }
  }
  dimension: _id { hidden: yes }
  dimension: is_used_on_dashboard {
    view_label: "Look"
    type: yesno
    sql: ${_id} IS NOT NULL ;;
  }
}
