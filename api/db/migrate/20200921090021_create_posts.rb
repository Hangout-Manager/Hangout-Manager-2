class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :label_id
      t.integer :user_id
      t.string :tag
      t.integer :upper_number

      t.timestamps
    end
  end
end
