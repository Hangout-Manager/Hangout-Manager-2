class AddQuestionsToCovidQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :covid_questions, :q4, :integer
    add_column :covid_questions, :q5, :integer
  end
end
