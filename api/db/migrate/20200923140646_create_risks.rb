class CreateRisks < ActiveRecord::Migration[6.0]
  def change
    create_table :risks do |t|
      t.integer :value
      t.integer :hangout_id

      t.timestamps
    end
  end
end
