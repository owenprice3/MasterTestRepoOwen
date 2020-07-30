view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    # html: {% assign words = value | split: ' ' %} {% assign numwords = 0 %}
    # {% for word in words %} {% assign numwords = numwords | plus: 1 %}
    # {% assign mod = numwords | modulo: 2 %} {% if mod == 0 %} {{ word }}
    # {% endif %} {% endfor %} ;;
    html: {% if products.brand.size <= 10 %}
    <p style="color: black;  text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black;  text-align:center">{{ rendered_value | slice: 0, 10 }}<br>{{ rendered_value | slice: 10, 20 }}</p>
    {% endif %}
    ;;
  }
  dimension: brand_logo {
    type: string
    sql: ${TABLE}.brand ;;
    #html: <img src="smiley.gif" /><br> ;;
    html:   <video>
    <source src="https://cdn.bitdegree.org/learn/Pexels%20Videos%203373.mp4?raw=true" type="video/mp4"> Video tag is unsupported
    in this browser
  </video> ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
