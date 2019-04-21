class CreateUserAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_addresses do |t|
      t.integer :user_id
      t.string :name
      t.string :mobile
      t.string :province
      t.string :city
      t.string :country
      t.string :detail

      t.timestamps
    end
    add_index :user_addresses, :user_id
  end
end
