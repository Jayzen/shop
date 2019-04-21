class BannerItem < ApplicationRecord
  belongs_to :banner, optional: true
  belongs_to :image, optional: true
  belongs_to :product, optional: true
end
