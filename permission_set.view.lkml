view: permission_set {

  dimension: id {
    primary_key: yes
    description: "The unique numeric identifier for the permission set"
    type: number
  }

  dimension: edit_link {
    description: "A link to the Admin page used to edit the permission set"
    type: string
    sql: ${id} ;;
    html: <a href='/admin/permission_sets/{{value}}/edit'>Edit</a> ;;
  }

  dimension: built_in {
    description: "Is this a built-in permission set?"
    type: yesno
  }

  dimension: embed {
    description: "Is this permission set specific to embed users?"
    type: yesno
  }

  dimension: name {
    description: "The name of the permission set"
    type: string
  }

  dimension: permissions {
    description: "A list of the permissions included in this permission set"
    type: string
  }

  dimension: unlimited {
    description: "Does this permission set grant unlimited permissions, regardless of which permissions are listed?"
    type: yesno
  }

  measure: permissions_list {
    description: "A list of the permissions included in this permission set"
    type: string
    sql:  {% if _dialect._name == 'hypersql' or _dialect._name == 'mysql' %}
            group_concat(DISTINCT ${permissions})
          {% elsif _dialect._name == 'bigquery_standard_sql' %}
            STRING_AGG(DISTINCT ${permissions})
          {% elsif _dialect._name == 'snowflake' %}
            LISTAGG(DISTINCT ${permissions})
          {% endif %} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, role.count]
  }
}
