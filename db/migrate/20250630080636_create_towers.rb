class CreateTowers < ActiveRecord::Migration[8.0]
  def change
    create_table :towers do |t|
      t.string :name
      t.integer :total_floors
      t.timestamps
    end
  end
end
