view: source_query_rank {
  derived_table: {
    explore_source: history {
      column: query_run_count {}
      column: sorted_source { field: history.source }
      filters: {
        field: history.source
        value: "-NULL"
      }
      sort: {
        desc:  yes
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
  dimension: sorted_source {
    label: "Source"
    description: "(Sorted by query run count) The source of a query, such as a saved Look, Explore, scheduled task, API, etc"
    order_by_field: query_run_count
  }
}
