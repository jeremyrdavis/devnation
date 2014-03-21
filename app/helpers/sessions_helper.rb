module SessionsHelper

	def current_customer
		puts "Calling current_customer"
		@current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
	end
end
