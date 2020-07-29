view: node {

  dimension: id {
    description: "Every time a node starts up, a record in the node table is generated. The ID field is the unique numeric identifier for the record generated at startup."
    primary_key: yes
    type: number
  }

  dimension: cache_port {
    hidden: yes
    type: string
  }

  dimension: clustered {
    description: "Is this node part of a clustered Looker installation?"
    type: yesno
  }

  dimension: hostname {
    description: "The node's unique IP address or hostname that other nodes use to contact this one"
    type: string
  }

  dimension: is_master {
    description: "If this is a clustered installation, is this the master node?"
    type: yesno
  }

  dimension_group: last_heartbeat {
    description: "The date and time the node most recently transmitted a heartbeat message to the other nodes in the cluster. The heartbeat message transmits system information about the node to the other nodes in the cluster, verifying the node's presence in the cluster."
    type: time
    sql:  {% if _dialect._name == 'bigquery_standard_sql' %}
            TIMESTAMP_MICROS(${TABLE}.LAST_HEARTBEAT)
          {% else %}
            ${TABLE}.LAST_HEARTBEAT
          {% endif %} ;;
  }

  dimension: mac_adress {
    description: "The node's MAC address"
    type: string
  }

  dimension: node_cluster_version {
    description: "A number that is incremented whenever changes to a node make inter-node communication impossible, and the node must be updated to make inter-node communication possible. This number should be identical for all nodes communicating in a cluster."
    type: number
  }

  dimension: node_to_node_port {
    description: "The port number used for inter-node communication"
    type: string
  }

  dimension: port {
    description: "The port number on which the node listens for connections to Looker"
    type: string
  }

  dimension: prev_node_id {
    description: "The unique numeric identifier for the record generated the last time the node started up"
    type: number
  }

  dimension: queue_broker_port {
    description: "The port number used for queueing cluster-wide events"
    type: string
  }

  dimension: version {
    description: "The Looker version running on the node"
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      prev_node_id,
      hostname,
      active_data_maintenance_task.count,
      cache_index.count,
      history.count,
      render_job.count,
      scheduled_job_stage.count,
      system_status.count
    ]
  }
}
