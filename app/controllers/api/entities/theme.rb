module API
  module Entities
    class Theme < Grape::Entity
      expose :id
      expose :head_image, using: API::Entities::Image
      expose :topic_image, using: API::Entities::Image
      expose :products, using: API::Entities::Product
    end
  end
end
