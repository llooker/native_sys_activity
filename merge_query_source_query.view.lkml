view: merge_query_source_query {

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: merge_query_id {
    hidden: yes
    type: number
  }
  dimension: query_id {
    hidden: yes
    type: number
  }

  dimension: rank { type: number }
  dimension: name {}
  dimension: merge_fields {}

  measure: count {
    type: count
  }
}
