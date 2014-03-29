class AddCustomerIndexToCheckingAccount < ActiveRecord::Migration
  def change
  	add_index :checking_account, [:customer_id]
  end
end
