class CreateCovidQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_questions do |t|
      t.string :name
      t.integer :q1
      t.integer :q2
      t.integer :q3

      t.timestamps
    end
  end
end
