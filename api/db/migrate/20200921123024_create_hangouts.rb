class CreateHangouts < ActiveRecord::Migration[6.0]
  def change
    create_table :hangouts do |t|
      t.string :name
      t.float :agon
      t.float :alea
      t.float :mimicry
      t.float :ilinx

      t.timestamps
    end
  end
end
