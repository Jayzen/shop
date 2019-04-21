module API
  module Entities
    class Product < Grape::Entity
      expose :id
      expose :name
      expose :price
      expose :stock
      expose :image, using: API::Entities::Image
      expose :product_images, using: API::Entities::ProductImage
      expose :product_properties, using: API::Entities::ProductProperty
    end
  end
end
