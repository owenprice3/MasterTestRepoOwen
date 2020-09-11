connection: "thelook"

# include all the views
include: "/views/**/*.view"

datagroup: owen_test_default_datagroup {
   sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: owen_test_default_datagroup

explore: events {
  description: "I'm just writing a good amount of text here to see if I can repro an issue with explore descriptions"
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  #always_filter: {
   # filters: [id: "15", users.first_name: "BCBS_NC"]
  #}
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  aggregate_table: test_liquid_input {
    query: {
      dimensions: [orders.id, orders.date]
      measures: [count]

    }

    materialization: {
      datagroup_trigger: owen_test_default_datagroup
    }
  }
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

}

explore: products {
  description: "This is a really different description test since I want to see if this gets cached weirdly or not"
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: xin_test_for_bug2 {}
