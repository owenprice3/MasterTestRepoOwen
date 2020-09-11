view: reference_lookml_dt {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'order_items.returned_week'


      SELECT
          (DATE_FORMAT(TIMESTAMP(DATE(DATE_ADD(CONVERT_TZ(`returned_at`,'UTC','America/Los_Angeles'),INTERVAL (0 - MOD((DAYOFWEEK(CONVERT_TZ(`returned_at`,'UTC','America/Los_Angeles')) - 1) - 1 + 7, 7)) day))), '%Y-%m-%d')) AS `order_items.returned_week`,
          (DATE_FORMAT(order_items.returned_at ,'%Y-%m')),
          COUNT(*) AS `order_items.count`,
          COUNT(DISTINCT order_items.id ) AS `order_items.distinct_count_test`
      FROM
          `demo_db`.`order_items` AS `order_items`
      GROUP BY
          1,2
      ORDER BY
          (DATE_FORMAT(TIMESTAMP(DATE(DATE_ADD(CONVERT_TZ(`returned_at`,'UTC','America/Los_Angeles'),INTERVAL (0 - MOD((DAYOFWEEK(CONVERT_TZ(`returned_at`,'UTC','America/Los_Angeles')) - 1) - 1 + 7, 7)) day))), '%Y-%m-%d')) DESC
      LIMIT 10
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_returned_week {
    type: string
    sql: ${TABLE}.`order_items.returned_week` ;;
  }

  dimension: date_formatorder_items_returned_at_ym {
    type: string
    label: "(DATE_FORMAT(order_items.returned_at ,'%Y-%m'))"
    sql: ${TABLE}.`(DATE_FORMAT(order_items.returned_at ,'%Y-%m'))` ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.`order_items.count` ;;
  }

  dimension: order_items_distinct_count_test {
    type: number
    sql: ${TABLE}.`order_items.distinct_count_test` ;;
  }

  set: detail {
    fields: [order_items_returned_week, date_formatorder_items_returned_at_ym, order_items_count, order_items_distinct_count_test]
  }
}
