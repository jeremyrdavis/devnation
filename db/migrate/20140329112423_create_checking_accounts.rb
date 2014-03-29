class CreateCheckingAccounts < ActiveRecord::Migration
  def change
    create_table :checking_accounts do |t|
      t.string :account_number
      t.integer :customer_id
      t.decimal :balance

      t.timestamps
    end
  end
end
