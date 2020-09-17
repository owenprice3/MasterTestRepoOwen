view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
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
  measure: max_created_date {
    type: date
    sql: ${created_raw} ;;
    convert_tz: no
  }

  measure: most_recent_date {
    type: yesno
    sql: max(${created_date}) ;;
  }

  measure: sum_cost {
    type: sum
    sql: ${cost} ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  measure: average_cost {
    type: average
    description: "Average cost of items sold from inventory"
    sql: ${inventory_items.cost} ;;
    value_format_name: "usd"
  }
  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }
}
