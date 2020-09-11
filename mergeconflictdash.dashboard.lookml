- dashboard: pie_chart
  title: Pie Chart
  layout: newspaper
  elements:
  - title: Total
    name: Total
    model: owen_test
    explore: order_items
    type: single_value
    fields: [order_items.count, products.count, products.category]
    sorts: [order_items.count desc, products.category]
    limit: 500
    total: true
    row_total: right
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: "${order_items.count:total}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    show_value_labels: false
    font_size: 16
    hide_legend: true
    series_colors:
      Row Total - order_items.count: "#592EC2"
    series_labels: {}
    value_labels: legend
    label_type: labPer
    inner_radius: 90
    series_types: {}
    defaults_version: 1
    hidden_fields: [order_items.count, products.count]
    y_axes: []
    row: 0
    col: 14
    width: 5
    height: 4
  - title: Pie Chart
    name: Pie Chart
    model: owen_test
    explore: order_items
    type: looker_pie
    fields: [products.category, order_items.count, products.count]
    sorts: [order_items.count desc, products.category]
    limit: 500
    total: true
    row_total: right
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: "${order_items.count:total}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    value_labels: none
    label_type: labPer
    inner_radius: 65
    series_colors:
      Row Total - order_items.count: "#592EC2"
    series_labels: {}
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Total
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_value_labels: false
    font_size: 16
    hide_legend: true
    series_types: {}
    defaults_version: 1
    hidden_fields: [products.count, calculation_1]
    y_axes: []
    title_hidden: true
    listen: {}
    row: 0
    col: 5
    width: 9
    height: 8
