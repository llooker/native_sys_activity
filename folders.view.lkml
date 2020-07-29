view: folders {
  sql_table_name: space ;;

  dimension: id {
    description: "The unique numeric identifier for a Folder"
    primary_key: yes
    type: number
  }

  dimension: content_metadata_id {
    type: number
    hidden: yes
  }

  dimension_group: created {
    description: "When the Folder was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: creator_id {
    description: "The unique numeric ID of the user who created the Folder"
    type: number
  }

  dimension_group: deleted {
    description: "When the Folder was deleted"
    type: time
    sql: ${TABLE}.DELETED_AT ;;
  }

  dimension: external_id {
    description: "The external string ID of an embedded Folder"
    type: string
  }

  dimension: is_embed {
    description: "Is this Folder embedded?"
    type: yesno
  }

  dimension: is_embed_shared_root {
    description: "Is this the root Embed Shared Folder?"
    type: yesno
  }

  dimension: is_embed_users_root {
    description: "Is this the root Embed Users Folder?"
    type: yesno
  }

  dimension: is_personal {
    label: "Is Personal Root"
    description: "Is this a personal root folder?"
    type: yesno
  }

  dimension: is_personal_descendant {
    description: "Is this a child of a personal Folder?"
    type: yesno
  }

  dimension: is_shared_root {
    description: "Is this the root Shared Folder?"
    type: yesno
  }

  dimension: is_users_root {
    description: "Is this the root Users Folder?"
    type: yesno
  }

  dimension: name {
    description: "The name of the Folder"
    type: string
  }

  dimension: parent_id {
    description: "The unique numeric ID of the parent Folder"
    type: number
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      dashboard.count,
      look.count,
      folders_user.count
    ]
  }
}
