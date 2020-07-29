view: result_maker_lookup {
  sql_table_name: result_maker ;;

  dimension: id {
    primary_key: yes
    type: number
  }

  dimension: query_id { type: number }
  dimension: merge_query_id { type: number }

  dimension: is_query {
    type: yesno
    sql: ${query_id} IS NOT NULL ;;
  }

  dimension: is_merge_query {
    type: yesno
    sql: ${merge_query_id} IS NOT NULL ;;
  }
}
