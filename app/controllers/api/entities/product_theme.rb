module API
  module Entities
    class ProductTheme < Grape::Entity
      expose :id
      expose :name
      expose :price
      expose :image, using: API::Entities::Image
    end
  end
end
