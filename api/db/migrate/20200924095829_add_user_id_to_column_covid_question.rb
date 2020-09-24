class AddUserIdToColumnCovidQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :covid_questions, :user_id, :integer
  end
end
