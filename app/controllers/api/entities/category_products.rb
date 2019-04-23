module API
  module Entities
    class CategoryProducts < Grape::Entity
      expose :id
      expose :name
      expose :topic_image, using: API::Entities::Image
      expose :products, using: API::Entities::ProductCategory
    end
  end
end
