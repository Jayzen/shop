class CreateBannerItems < ActiveRecord::Migration[5.2]
  def change
    create_table :banner_items do |t|
      t.integer :product_id
      t.integer :image_id
      t.integer :banner_id
      t.string :name

      t.timestamps
    end
    add_index :banner_items, :banner_id
    add_index :banner_items, :image_id
    add_index :banner_items, :product_id
  end
end
