module API
  module Entities
    class Category < Grape::Entity
      expose :id
      expose :name
      expose :products, using: API::Entities::Product
    end
  end
end
