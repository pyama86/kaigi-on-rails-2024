module Types
  class CustomerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :is_loyal, Boolean, null: false
    field :orders, [ OrderType ], null: true

    def is_loyal
      Sentry.with_child_span(op: :process_is_loyal, description: "loyal costomer is good") do |span|
        object.loyal?
      end
    end

    def orders
      Loaders::AssociationLoader.for(Customer, :orders).load(object)
    end
  end
end
