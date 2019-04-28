class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :order_no
      t.integer :user_id
      t.decimal :total_price, precision: 5, scale: 2
      t.integer :total_count
      t.integer :status
      t.string :snap_img
      t.string :snap_name
      t.string :snap_items
      t.string :snap_address

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
