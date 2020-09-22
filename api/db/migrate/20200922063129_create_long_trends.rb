class CreateLongTrends < ActiveRecord::Migration[6.0]
  def change
    create_table :long_trends do |t|
      t.float :agon
      t.float :alea
      t.float :mimicry
      t.float :ilinx
      t.integer :user_id

      t.timestamps
    end
  end
end
