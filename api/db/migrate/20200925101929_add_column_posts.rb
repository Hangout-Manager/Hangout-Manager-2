class AddColumnPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :start_time, :time
    add_column :posts, :start_date, :date
    add_column :posts, :estimate_time, :integer
  end
end
