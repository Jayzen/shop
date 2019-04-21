class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2
      t.integer :stock
      t.integer :category_id
      t.integer :image_id
      t.text :description

      t.timestamps
    end
    add_index :products, :category_id
    add_index :products, :image_id
  end
end
