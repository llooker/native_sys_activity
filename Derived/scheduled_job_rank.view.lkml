view: scheduled_job_rank {
  derived_table: {
    explore_source: scheduled_plan {
      column: content_type_id {}
      column: scheduled_job_count { field: scheduled_job.count }
      bind_all_filters: yes
    }
  }
  dimension: content_type_id {
    description: "(sorted by scheduled job count) Content Type and ID"
    order_by_field: scheduled_job_count
  }
  dimension: scheduled_job_count {
    type: number
  }
}
