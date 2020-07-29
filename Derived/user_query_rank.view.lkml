## Used for heatmap visualizations on System Activity Dashboard
## Added by JM 10/14 (May need adaptability across dialects)

view: user_query_rank {
  derived_table: {
    explore_source: history {
      column: query_run_count {}
      column: user_name { field: user.name }
      filters: {
        field: user.name
        value: "-NULL"
      }
      sort: {
        desc: yes
        field: history.query_run_count
      }
      bind_all_filters: yes
    }
  }
  dimension: query_run_count {
    hidden: yes
    description: "The number of query runs (this field is best used in conjunction with a filter or pivot on history source)"
    type: number
  }
  dimension: user_name {
    description: "(Sorted by query run count) First and Last name of User"
    order_by_field: query_run_count
  }
}
