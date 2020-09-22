class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :q1
      t.integer :q2
      t.integer :user_id

      t.timestamps
    end
  end
end
