view: customers_orgs {
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE ;;
    indexes: ["customer_id"]
    sql: select
          stripe_api_customers.id as customer_id
        , (regexp_matches(stripe_api_customers.description, '^(?:Org: |Team: )?([a-zA-Z0-9\-\_]*)(?: -)?'))[1] as org_name
      FROM source_data.stripe_api_customers
       ;;
  }

dimension: org_name {
  type: string
  sql: ${TABLE}.org_name ;;
}
}
