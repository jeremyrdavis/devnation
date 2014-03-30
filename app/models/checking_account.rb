class CheckingAccount < ActiveRecord::Base
	belongs_to :customer #, :class_name => "Customer", :foreign_key => "customer_id"
	validates :customer_id, presence: true

	#always downcase email address to ensure uniqueness
	before_save { self.account_number = generate_account_number }

	def generate_account_number
		self.account_number = "DNB" + Random.rand(12345678).to_s
	end
end
