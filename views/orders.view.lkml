view: orders {
  #sql_table_name: {% parameter status_selector %}.orders ;;
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    #primary_key: yes
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
    default_value: "Day"
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
    suggest_persist_for: "0 seconds"
  }
  parameter: status_selector {
    type: unquoted
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
    allowed_value: {
      label: "Actual DB"
      value: "demo_db"
    }
  }
  dimension: broken_liquid_reference_CHAANGES {
    type: string
    sql: CASE
         WHEN {% parameter status_selector %} = 'complete' THEN ${order_items.id}
         ELSE ${users.gender}
         END;;
    link: {
      label: "Broken {{ value }}"
      url: "{% assign sbv = {{_filters['orders.status_selector']}} %}
            {% if sbv == 'complete' %}
            https://master.dev.looker.com/dashboards/3552?ID={{_filters['order_items.id']}}
            {% else %}
            https://master.dev.looker.com/dashboards/3552?Gender={{_filters['users.gender']}}
            {% endif %}
            "
    }
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: over_16_digits_number {
    primary_key: yes
    type: number
    sql: 123456789123456 * ${TABLE}.user_id ;;
    #value_format: "0"
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }
}
