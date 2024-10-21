# 大量の顧客データを生成
10.times do |i|
  customer = Customer.create(name: "Customer #{i}")

  # 各顧客に1つの注文を作成
  order = Order.create(customer: customer)

  # 各顧客に複数のセールスデータを作成
  10.times do |j|
    Sale.create(customer: customer)
  end
end
