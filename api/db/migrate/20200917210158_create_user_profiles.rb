class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.integer :age
      t.integer :sex
      t.integer :place
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
