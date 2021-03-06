view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: date_formatted {
    #sql: concat(${returned_date}, " thru ", ${returned_date}) ;;
    #html: {{ rendered_value  | date: "%Y/%m/%d"}} ;;
    sql: concat(concat(${returned_year}, "/", ${returned_month_num}, "/", ${returned_day_of_month}), " thru ", concat(${orders.created_year}, "/", ${orders.created_month_num}, "/", ${orders.created_day_of_month}));;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  measure: distinct_count_test {
    type: count_distinct
    #sql: ${TABLE}.id || ~ || ${order_id} || ~ || ${inventory_item_id} ;;
    sql: ${id} ;;
  }


  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }
  dimension_group: returned {
    type: duration
    intervals: [day, week, month]
    sql_start: ${TABLE}.returned_at = cast("09:00:00" as timestamp);;
    sql_end: cast(${TABLE}.returned_at = "17:00:00" as timestamp) ;;
  }

}
