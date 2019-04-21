class Category < ApplicationRecord
  has_many :products
  belongs_to :topic_image, class_name: "Image", foreign_key: "topic_img_id", optional: true
end
