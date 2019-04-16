class CreateBanks < ActiveRecord::Migration[5.1]
  def change
    create_table :banks do |t|
      t.string :bank_name
      t.integer :account_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
