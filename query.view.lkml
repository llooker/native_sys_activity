view: query {

  dimension: id {
    description: "The unique numeric identifier for the query"
    primary_key: yes
    type: number
  }

  dimension: column_limit {
    description: "The column limit applied to the query"
    type: string
  }

  dimension_group: created {
    description: "When the query was created"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: fields {
    hidden: yes
    description: "The fields used in the query"
    type: string
  }

  dimension: filters {
    hidden: no
    description: "The filters used in the query"
    type: string
  }

  dimension: formatted_fields {
    label: "Fields Used"
    description: "The fields used in the query"
    sql: REPLACE (${fields}, ',', ', ') ;;
  }

  dimension: fill_fields {
    description: "The fields in the query with dimension fill applied"
    type: string
  }

  dimension: hash {
    description: "The query's unique string identifier calculated from the generated SQL text"
    type: string
  }

  dimension: limit {
    label: "Row Limit"
    description: "The row limit applied to the query"
    type: number
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            SAFE_CAST(${TABLE}.limit AS INT64)
          {% else %}
            ${TABLE}.limit
          {% endif %} ;;
  }

  dimension: link {
    description: "A clickable link to the query. For filtering, use query id field instead."
    sql: ${id} ;;
    html: [<a href="/x/{{ slug._value }}">Query</a>] ;;
    required_fields: [slug]
    can_filter: no
#   remove required_fields once https://github.com/looker/helltool/issues/11419 is fixed
  }

  dimension: model {
    description: "The model used in the query"
    type: string
  }

  dimension: pivots {
    description: "The fields used as pivots in the query"
    type: string
  }

  dimension: formatted_pivots {
    description: "The pivots used in the query"
    label: "Pivots Used"
    sql: REPLACE (${pivots}, ',', ', ') ;;
  }

  dimension: query_timezone {
    description: "The timezone used for the query. If the default query timezone was used, the value of this field is null."
    type: string
  }

  dimension: row_total {
    description: "The position of the row total in the UI"
    type: string
  }

  dimension: slug {
    description: "The query's unique string ID, included in the URL"
    type: string
  }

  dimension: sorts {
    description: "The fields used as sorts in the query"
    type: string
  }

  dimension: total {
    description: "Were totals included in the query?"
    type: yesno
  }

  dimension: view {
    label: "Explore"
    description: "The Explore that uses the query"
    type: string
  }

  dimension: vis_config {
    description: "The JSON-encoded metadata of the visualization configuration"
    type: string
  }

  dimension: visible_ui_sections {
    label: "Visible UI Sections"
    type: string
  }

  measure: first_query_at {
    description: "When the query was first run"
    sql: MIN(${TABLE}.CREATED_AT) ;;
    drill_fields: [history.query_detail*]
  }

  measure: count {
    type: count
    drill_fields: [history.query_detail*]
  }

  measure: count_of_explores {
    description: "Count of distinct Explores queried"
    type: count_distinct
    sql: ${view} ;;
    drill_fields: [explore_detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      dashboard_element.count,
      history.count,
      look.count,
      slug.count
    ]
  }

  set: explore_detail {
    fields: [
      view,
      model,
      history.first_query_date,
      history.most_recent_query_date,
      history.query_run_count,
      history.explore_user
    ]
  }
}
