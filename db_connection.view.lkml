view: db_connection {
  label: "DB Connection"

  dimension: id {
    description: "The unique numeric identifier for the connection"
    primary_key: yes
    type: number
  }

  dimension: edit_link {
    description: "A clickable link to edit the connection"
    type: string
    sql: ${id} ;;
    html: <a href='/admin/connections/{{value}}/edit' rel="noopener">Edit</a> ;;
  }

  dimension_group: created {
    description: "When the connection was created"
    type: time
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            TIMESTAMP_MICROS(${TABLE}.CREATED_AT)
          {% else %}
            ${TABLE}.CREATED_AT
          {% endif %} ;;
  }

  dimension: database {
    description: "The name of the database"
    type: string
  }

  dimension: db_timezone {
    label: "DB Timezone"
    description: "The timezone in which the database stores dates, set in the connection"
    type: string
  }

  dimension: dialect {
    description: "The database's SQL dialect"
    type: string
  }

  dimension: host {
    description: "The database's host, set in the connection"
    type: string
  }

  dimension_group: last_reap_at {
    datatype: epoch
    type: time
    sql: ${TABLE}.last_reap_at ;;
  }

  dimension_group: last_regen_at {
    datatype: epoch
    type: time
    sql: ${TABLE}.last_regen_at ;;
  }

  dimension: maintenance_cron {
    description: "The cron string set in the connection that specifies a schedule for checking triggers and dropping expired tables"
    type: string
  }

  dimension: max_billing_gigabytes {
    description: "The maximum number of bytes billed allowed on a single BigQuery query in GBs (excluding PDTs), set in the connection"
    type: string
  }

  dimension: max_connections {
    description: "The max number of connections Looker will allow at one time, set in the connection"
    type: number
  }

  dimension: name {
    description: "The name of the connection"
    type: string
  }

  dimension: pool_timeout {
    description: "The number of seconds a query will wait before timing out due to a full connection pool, set in the connection"
    type: number
  }

  dimension: port {
    description: "The database's port, set in the connection"
    type: string
  }

  dimension: query_timezone {
    description: "The timezone in which to show dates and times when querying, set in the connection"
    type: string
  }

  dimension: reg_key {
    type: string
  }

  dimension: schema {
    description: "The default schema that Looker uses when a schema is not specified, set in the connection. Only applicable to some dialects."
    type: string
  }

  dimension_group: schema_busted {
    type: time
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            TIMESTAMP_MICROS(${TABLE}.SCHEMA_BUSTED_AT)
          {% else %}
            ${TABLE}.SCHEMA_BUSTED_AT
          {% endif %} ;;
  }

  dimension: sql_runner_precache_tables {
    description: "Are tables precached for faster lookup?"
    type: yesno
  }

  dimension: ssl {
    label: "SSL"
    description: "Is this connection using SSL encryption?"
    type: yesno
  }

  dimension: tmp_db_name {
    label: "Temporary DB Name"
    description: "The schema or database (depending on your dialect) in which Looker will write persistent derived tables, set in the connection"
    type: string
  }

  dimension: user_attribute_fields {
    description: "The fields used in the connection whose values map to user attribute names"
    type: string
  }

  dimension: user_id {
    description: "The unique numeric ID of the user who created the connection"
    type: number
    # hidden: yes
  }

  dimension: uses_tns {
    label: "Uses TNS"
    description: "Does the connection use TNS? Only applicable to Oracle connections."
    type: yesno
  }

  dimension: verify_ssl {
    label: "Verify SSL"
    description:"Does the connection require verification of the certificate? Unverified certificates still ensure encryption."
    type: yesno
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      user.dev_branch_name,
      user.last_name,
      user.first_name,
      user.id,
      lookml_model_db_connection.count,
      upload_table.count
    ]
  }
}
