class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :from_account_id
      t.string :to_account_id
      t.decimal :amount
      t.datetime :timestamp

      t.timestamps
    end
  end
end
