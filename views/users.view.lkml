view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: case when ${TABLE}.country = 'USA' then 'United States of America' end;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender_test{
    type: yesno
    sql: ${TABLE}.gender = 'm' ;;
    description: "Yes if Male"
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: gender_html {
    sql: IF(${gender} = 'm', "https://upload.wikimedia.org/wikipedia/commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Mud_Cow_Racing_-_Pacu_Jawi_-_West_Sumatra%2C_Indonesia.jpg/1200px-Mud_Cow_Racing_-_Pacu_Jawi_-_West_Sumatra%2C_Indonesia.jpg")  ;;
    html: <img src="{{ rendered_value }}" width="100" height="100"/> ;;
  }
  dimension: gender_conditional_link {
    type: string
    sql: ${TABLE}.gender ;;
    html: {% if users.gender._value == "m" %}
<a href="https://www.google.com/search?q={{ value }}">{{ value }}</a>
{% else %}
<a href="https://www.google.com/search?q={{ value }}">{{ value }}</a>
{% endif %} ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state_news_button {
    type: string
    sql: ${TABLE}.state ;;
    html: <a href="http://www.google.com/search?q=coronavirus%20{{ value }}"><button>State News</button></a> ;;
  }

  dimension: state_with_covid_search {
    type: string
    sql: ${TABLE}.state ;;
    drill_fields: [zip]
    html: <a href="http://www.google.com/search?q=coronavirus%20{{ value }}" target="_new">{{value}}<button>State News</button></a> <a href="#drillmenu" target="_self">⚠️</a> ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
