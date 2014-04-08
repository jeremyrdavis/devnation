class AtmController < ApplicationController
  
  def show
  	@customer = view_context.current_customer
  	if @customer 
  		puts @customer
        flash[:message] = "Welcome to DevNation Bank ATM, #{@customer.first_name}"
  	else
        flash[:message] = "Welcome to DevNation Bank ATM.  Choose the appropriate account below."
  	end
  end

end
