class CreateThemeProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :theme_products do |t|
      t.integer :theme_id
      t.integer :product_id

      t.timestamps
    end
    add_index :theme_products, [:theme_id, :product_id], unique: true
  end
end
