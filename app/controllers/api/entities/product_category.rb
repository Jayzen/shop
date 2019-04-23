module API
  module Entities
    class ProductCategory < Grape::Entity
      expose :id
      expose :name
      expose :image, using: API::Entities::Image
    end
  end
end
