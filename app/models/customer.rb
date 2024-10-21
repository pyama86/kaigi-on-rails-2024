class Customer < ApplicationRecord
  has_many :orders
  has_many :sales

  def loyal?
    sales.exists?
  end
end
