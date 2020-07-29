view: user {
  sql_table_name: user ;;

  dimension: id {
    primary_key: yes
    description: "The unique numeric identifier for a user"
    type: number
  }

  dimension_group: created {
    description: "When this user was created"
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: dev_branch_name {
    description: "The name of the user's personal developer branch"
    type: string
  }

  dimension: edit_link {
    description: "A clickable link to this user's edit page. For filtering, use user id field instead."
    type: string
    sql: ${id} ;;
    html: <a href='/admin/users/{{value}}/edit'>Edit</a> ;;
    can_filter: no
  }

  dimension: email {
    description: "The email address associated with the user account"
    type: string
  }

  dimension: external_avatar_url {
    description: "The public URL of the user's profile photo"
    type: string
  }

  dimension: first_name {
    description: "The user's first name"
    type: string
    sql:  {% if _dialect._name == 'mysql' %}
            CONVERT(${TABLE}.first_name USING utf8mb4)
          {% else %}
            ${TABLE}.first_name
          {% endif %} ;;
  }

  dimension: home_space_id {
    description: "The Space ID of the user's personal Space (type string)"
    type: string
  }

  dimension: is_disabled {
    description: "Has this user's account been disabled?"
    type: yesno
  }

  dimension: last_name {
    description: "The user's last name"
    type: string
    sql:  {% if _dialect._name == 'mysql' %}
            CONVERT(${TABLE}.last_name USING utf8mb4)
          {% else %}
            ${TABLE}.last_name
          {% endif %} ;;
  }

  dimension: name {
    description: "The user's full name"
    type: string
    sql: CONCAT(${first_name}, ' ', ${last_name}) ;;
  }

  dimension: timezone {
    description: "The user's timezone, if set"
    type: string
  }

  measure: count {
    type: count
    drill_fields: [user_detail*]
  }

  # ----- Sets of fields for drilling ------
#   set: detail {
#     fields: [
#       id,
#       dev_branch_name,
#       last_name,
#       first_name,
#       content_favorite.count,
#       dashboard.count,
#       db_connection.count,
#       event.count,
#       group.count,
#       history.count,
#       look.count,
#       role_user.count,
#       scheduled_plan.count,
#       session.count,
#       folders_user.count,
#       sql_query.count,
#       user_attribute.count,
#       user_attribute_user_value.count,
#       user_facts.count,
#     ]
#   }

  set: user_detail {
    fields: [
      id,
      first_name,
      last_name,
      created_date,
      edit_link,
      email,
      is_disabled,
      group.count,
      history.count,
      session.count,
      user_facts.last_ui_login_date,
    ]
  }
}

#Used for self joins to grab username if not already provided
view: _usernames {
  extends: [user]
  dimension: sudo_user_name {sql: ${name} ;; description: "The full name of the sudo user"}
}
