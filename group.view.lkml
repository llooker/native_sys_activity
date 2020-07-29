view: group {
  sql_table_name: {% if _dialect._name == 'hypersql' %} "GROUP" {% else %} `group` {% endif %} ;;

  dimension: id {
    description: "The unique numeric identifier for the group"
    primary_key: yes
    type: number
  }

  dimension: can_add_to_content_metadata {
    description: "Can the group be used in content access controls?"
    type: yesno
  }

  dimension: edit_link {
    description: "A link to the Admin page used to edit the group's properties"
    type: string
    sql: ${id} ;;
    html: <a href='/admin/groups?groupId={{value}}' rel="noopener">Edit</a> ;;
  }

  dimension: external_group_id {
    description: "If the group membership is controlled outside of Looker, the unique string identifier given to the group by the outside source"
    type: string
  }

  dimension: externally_managed {
    description: "Is the group membership controlled outside of Looker?"
    type: yesno
  }

  dimension: include_by_default {
    description: "Are new users added to this group by default?"
    type: yesno
  }

  dimension: name {
    description: "The group name"
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_externally_managed {
    description: "The total number of groups where membership is controlled outside of Looker"
    type: count
    filters: {
      field: externally_managed
      value: "yes"
    }
    drill_fields: [detail*]
  }

  measure: groups {
    description: "A comma-separated string of group names showing which groups are represented by the row of data"
    type: string
    sql:  {% if _dialect._name == 'hypersql' or _dialect._name == 'mysql' %}
            group_concat(DISTINCT ${name})
          {% elsif _dialect._name == 'bigquery_standard_sql' %}
            STRING_AGG(DISTINCT ${name})
          {% elsif _dialect._name == 'snowflake' %}
            LISTAGG(DISTINCT ${name})
          {% endif %} ;;
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      user.count,
      role_group.count,
      user_attribute_group_value.count,
      edit_link,
      include_by_default,
      externally_managed,
      external_group_id
    ]
  }
}
