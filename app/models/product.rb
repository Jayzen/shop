class Product < ApplicationRecord
  has_many :theme_products
  has_many :themes, through: :theme_products
  has_many :product_images
  has_many :product_properties
  has_many :order_products
  has_many :orders, through: :order_products 
  
  has_one :banner_item

  belongs_to :category, optional: true
  belongs_to :image, optional: true
end
