class CreateWings < ActiveRecord::Migration[8.0]
  def change
    create_table :wings do |t|
      t.string :name

      t.timestamps
    end
  end
end
