module API
  module Entities
    class Image < Grape::Entity
      expose :link

      private
        def link
          if Rails.env == "production"
            link = "https://zhengjiajun.com" + object.link.url.to_s
          else
            link = "http://localhost:3000" + object.link.url.to_s
          end
        end
    end
  end
end
