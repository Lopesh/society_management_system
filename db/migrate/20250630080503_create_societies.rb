class CreateSocieties < ActiveRecord::Migration[8.0]
  def change
    create_table :societies do |t|
      t.string :name
      t.string :subdomain
      t.string :address
      t.string :contact_email
      t.string :phone

      t.timestamps
    end
    add_index :societies, :subdomain, unique: true
  end
end
