class CheckingAccount < ActiveRecord::Base
	belongs_to :customer #, :class_name => "Customer", :foreign_key => "customer_id"
	has_many :withdrawls, :class_name => "Transaction", :foreign_key => "from_account_id", :primary_key => "account_number"
	has_many :deposits, :class_name => "Transaction", :foreign_key => "to_account_id", :primary_key => "account_number"
	validates :customer_id, presence: true

	#always generate a random account number
	before_save { self.account_number = generate_account_number }

	def generate_account_number
		self.account_number = "DNB" + Random.rand(12345678).to_s
	end

	def all_transactions
		return Array.new(self.withdrawls + self.deposits)
	end
end
