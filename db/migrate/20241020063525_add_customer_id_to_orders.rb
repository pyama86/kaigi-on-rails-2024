class AddCustomerIdToOrders < ActiveRecord::Migration[7.2]
  def change
    add_reference :orders, :customer, null: false, foreign_key: true
  end
end
