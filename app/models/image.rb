class Image < ApplicationRecord
  mount_uploader :link, ImageUploader

  has_one :banner_item
  has_one :product
  has_one :category

  #has_one :topic_image, class_name: "Image"
  #has_one :head_image, class_name: "Image"
end
