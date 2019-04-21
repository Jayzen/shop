module API
  module Entities
    class ProductImage < Grape::Entity
      expose :id
      expose :image, using: API::Entities::Image
    end
  end
end
