module API
  module Entities
    class ThemeIndex < Grape::Entity
      expose :id
      expose :name
      expose :topic_image, using: API::Entities::Image
    end
  end
end
