class Transaction < ActiveRecord::Base
	belongs_to :from_account, :class_name => "CheckingAccount"
	belongs_to :to_account, :class_name => "CheckingAccount"

	before_save :create_timestamp  

	def create_timestamp    
		@timestamp = DateTime.now  
	end
end
