class ProductImage < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :image, optional: true
end
