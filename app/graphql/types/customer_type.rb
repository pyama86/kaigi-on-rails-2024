module Types
  class CustomerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :is_loyal, Boolean, null: false
    field :orders, [ OrderType ], null: true

    def is_loyal
      Loaders::AssociationLoader.for(Customer, :sales).load(object) do |sales|
        object.loyal?
      end
    end

    def orders
      Loaders::AssociationLoader.for(Customer, :orders).load(object)
    end
  end
end
