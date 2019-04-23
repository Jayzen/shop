module API
  module Entities
    class Theme < Grape::Entity
      expose :id
      expose :head_image, using: API::Entities::Image
      expose :products, using: API::Entities::ProductTheme
    end
  end
end
