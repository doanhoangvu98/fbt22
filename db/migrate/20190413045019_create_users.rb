class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :phone
      t.string :email
      t.string :picture
      t.integer :role, default: 0
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
