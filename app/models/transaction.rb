class Transaction < ActiveRecord::Base

	before_save :create_timestamp  

	def create_timestamp    
		@timestamp = DateTime.now  
	end
end
