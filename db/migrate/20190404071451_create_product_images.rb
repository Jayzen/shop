class CreateProductImages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_images do |t|
      t.integer :image_id
      t.integer :order
      t.integer :product_id

      t.timestamps
    end
    add_index :product_images, :product_id
    add_index :product_images, :image_id
  end
end
