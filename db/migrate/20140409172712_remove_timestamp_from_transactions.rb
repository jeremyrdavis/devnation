class RemoveTimestampFromTransactions < ActiveRecord::Migration
  def change
  	remove_column :transactions, :timestamp, :datetime
  end
end
