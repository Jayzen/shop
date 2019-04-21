class ProductProperty < ApplicationRecord
  belongs_to :product, optional: true
end
