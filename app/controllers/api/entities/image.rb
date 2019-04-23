module API
  module Entities
    class Image < Grape::Entity
      expose :link

      private
        def link
          link = "https://zhengjiajun.com" + object.link.url.to_s
        end
    end
  end
end
