module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :customer, CustomerType, null: true

    def customer
      Loaders::AssociationLoader.for(Order, :customer).load(object)
    end
  end
end
