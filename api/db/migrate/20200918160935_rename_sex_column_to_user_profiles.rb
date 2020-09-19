class RenameSexColumnToUserProfiles < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_profiles, :sex, :sex_id
    rename_column :user_profiles, :place, :place_id
  end
end
