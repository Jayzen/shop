class CreateProductProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :product_properties do |t|
      t.string :name
      t.text :detail
      t.integer :product_id

      t.timestamps
    end
    add_index :product_properties, :product_id
  end
end
