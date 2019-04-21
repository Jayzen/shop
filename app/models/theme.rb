class Theme < ApplicationRecord
  has_many :theme_products
  has_many :products, through: :theme_products

  belongs_to :topic_image, class_name: "Image", foreign_key: "topic_img_id"
  belongs_to :head_image, class_name: "Image", foreign_key: "head_img_id"
end
