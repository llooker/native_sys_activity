view: user_facts {
  label: "User Facts (updated hourly)"

  dimension: id {
    description: "The unique numeric identifier for the user_facts table"
    primary_key: yes
    type: number
  }

  dimension: active_api_sessions {
    label: "Active API Sessions"
    description: "The number of active API sessions for this user"
    type: number
  }

  dimension: active_ui_sessions {
    label: "Active UI Sessions"
    description: "The number of active sessions for this user in the Looker UI"
    type: number
  }

  dimension: external_id {
    description: "The ID of the user from an external source, such as SAML or embed"
    type: string
  }

  dimension: has_api_credentials {
    label: "Has API Credentials"
    description: "Does this user have API credentials?"
    type: yesno
  }

  dimension: has_ui_credentials {
    label: "Has UI Credentials"
    description: "Does this user have Looker UI credentials?"
    type: yesno
  }

  dimension: is_admin {
    group_label: "User Permissions"
    description: "Does this user have the admin role?"
    type: yesno
  }

  dimension: is_developer {
    group_label: "User Permissions"
    description: "Does this user have the develop permission on at least one model?"
    type: yesno
  }

  dimension: is_viewer {
    group_label: "User Permissions"
    description: "Does this user have the access_data permission on at least one model?"
    type: yesno
  }

  dimension: is_embed {
    group_label: "User Permissions"
    description: "Is this an SSO embed user? (Does not include private embed users)"
    type: yesno
  }

  dimension: is_explorer {
    group_label: "User Permissions"
    description: "Does this user have the explore permission on at least one model?"
    type: yesno
  }

  dimension: is_content_saver {
    group_label: "User Permissions"
    description: "Does this user have the save_content permission on at least one model?"
    type: yesno
  }

  dimension: is_presumed_looker_employee {
    type: yesno
    hidden: yes
  }

  dimension: is_verified_looker_employee {
    type: yesno
    hidden: yes
  }

  dimension: is_looker_employee {
    group_label: "User Permissions"
    description: "Is this user a Looker employee?"
    type: yesno
    sql: ${is_presumed_looker_employee} or ${is_verified_looker_employee} ;;
  }

  dimension_group: last_api_login {
    label: "Last API Login"
    description: "The last time the user logged in via the API"
    type: time
    sql: ${TABLE}.LAST_API_LOGIN_AT ;;
  }

  dimension_group: last_ui_login {
    label: "Last UI Login"
    description: "The last time the user logged in via the Looker UI"
    type: time
    sql: ${TABLE}.LAST_UI_LOGIN_AT ;;
  }

  dimension: last_ui_login_credential_type {
    label: "Last UI Login Credential Type"
    description: "The type of credentials used the last time this user logged in to the Looker UI"
    type: string
  }

  dimension: user_id {
    description: "The unique numeric identifier for a user"
    type: number
    # hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [user.user_detail*]
  }
}
