module API
  module Entities
    class Banner < Grape::Entity
      expose :name
      expose :description
      expose :banner_items, using: API::Entities::BannerItem
    end
  end
end
