module API
  module Entities
    class Image < Grape::Entity
      expose :link

      private
        def link
          link = "http://localhost:3000" + object.link.url.to_s
        end
    end
  end
end
