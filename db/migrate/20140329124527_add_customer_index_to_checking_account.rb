class AddCustomerIndexToCheckingAccount < ActiveRecord::Migration
  def change
  	add_index :checking_accounts, [:customer_id]
  end
end
