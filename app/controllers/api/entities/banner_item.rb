module API
  module Entities
    class BannerItem < Grape::Entity
      expose :product, using: API::Entities::Product
      expose :image, using: API::Entities::Image
    end
  end
end
