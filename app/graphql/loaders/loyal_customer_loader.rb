class Loaders::LoyalCustomerLoader < GraphQL::Batch::Loader
  def perform(customers)
    ids_placeholder = customers.map { "?" }.join(", ")
    rank_query = <<~SQL.squish
      WITH ranked_sales AS (
        SELECT sales.customer_id,
            sales.id AS sale_id,
            ROW_NUMBER() OVER (PARTITION BY sales.customer_id ORDER BY sales.id) AS rank_sale
        FROM
            sales
        WHERE
            customer_id IN (#{ids_placeholder})
      )

      SELECT
          ranked_sales.customer_id,
          ranked_sales.sale_id
      FROM
          ranked_sales
      WHERE
          ranked_sales.rank_sale = 1
    SQL

    customer_ids = customers.map(&:id)
    result = ActiveRecord::Base.connection.select_all(
      ActiveRecord::Base.send(:sanitize_sql_array, [ rank_query, *customer_ids ])
    )

    customers.each do |customer|
      customer_sale = result.find { |row| row["customer_id"] == customer.id }
      fulfill(customer, customer_sale.present?)
    end
    customers.each { |customer| fulfill(customer, nil) unless fulfilled?(customer)  }
  end
end
