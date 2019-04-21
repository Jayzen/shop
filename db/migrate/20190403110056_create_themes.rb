class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.string :name
      t.text :description
      t.integer :topic_img_id
      t.integer :head_img_id

      t.timestamps
    end
  end
end
