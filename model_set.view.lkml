view: model_set {

  dimension: id {
    description: "The unique numeric identifier for the model set"
    primary_key: yes
    type: number
  }

  dimension: edit_link {
    description: "A link to the Admin page used to edit the model set"
    type: string
    sql: ${id} ;;
    html: <a href='/admin/model_sets/{{value}}/edit'>Edit</a> ;;
  }

  dimension: built_in {
    description: "Is this a built-in model set?"
    type: yesno
  }

  dimension: embed {
    description: "Is this model set specific to embed users?"
    type: yesno
  }

  dimension: models {
    description: "A list of the models included in this model set"
    type: string
  }

  dimension: name {
    description: "The name of the model set"
    type: string
  }

  dimension: unlimited {
    description: "Does this model set grant unlimited permissions, regardless of which models are listed?"
    type: yesno
  }

  measure: models_list {
    description: "A list of the models included in this model set"
    type: string
    sql:  {% if _dialect._name == 'hypersql' or _dialect._name == 'mysql' %}
            group_concat(DISTINCT ${models})
          {% elsif _dialect._name == 'bigquery_standard_sql' %}
            STRING_AGG(DISTINCT ${models})
          {% elsif _dialect._name == 'snowflake' %}
            LISTAGG(DISTINCT ${models})
          {% endif %} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, role.count]
  }
}
