module API
  module Entities
    class ProductProperty < Grape::Entity
      expose :name
      expose :detail
    end
  end
end
