view: slug {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: guid {
    type: string
  }

  dimension_group: last_fetched {
    type: time
  }

  dimension: query_id {
    type: number
    # hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, query.id]
  }
}
