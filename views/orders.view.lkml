view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }
  parameter: date_granularity {
    group_label: "Definitely Not Date Granularity"
    type: string
    allowed_value: { value: "Day" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }

  dimension: date {
    label_from_parameter: date_granularity
    sql:
    CASE
      WHEN {% parameter date_granularity %} = 'Day'
        THEN ${created_date}
      WHEN {% parameter date_granularity %} = 'Month'
        THEN ${created_month}
      WHEN {% parameter date_granularity %} = 'Quarter'
        THEN ${created_quarter}
      WHEN {% parameter date_granularity %} = 'Year'
        THEN ${created_year}
      ELSE NULL
    END ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  parameter: status_selector {
    default_value: "complete"
    allowed_value: {
      value: "complete"
    }
    allowed_value: {
      value: "pending"
    }
    allowed_value: {
      value: "cancelled"
    }
  }
  dimension: broken_liquid_reference {
    type: string
    sql: CASE
         WHEN {% parameter status_selector %} = 'complete' THEN ${order_items.id}
         ELSE ${users.gender}
         END;;
    link: {
      label: "Broken {{ value }}"
      url: "{% assign sbv = {{_filters['orders.status_selector']}} %}
            {% if sbv == 'complete' %}
            https://master.dev.looker.com/dashboards/3552?Brand={{_filters['products.brand']}}
            {% else %}
            https://docs.looker.com
            {% endif %}
            "
    }
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }
}
