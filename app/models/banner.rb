class Banner < ApplicationRecord
  has_many :banner_items, dependent: :destroy

  alias new_banner_items banner_items
  def banner_items
    self.new_banner_items.includes(:image)
  end
end
