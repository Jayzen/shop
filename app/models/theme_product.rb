class ThemeProduct < ApplicationRecord
  belongs_to :theme
  belongs_to :product
end
