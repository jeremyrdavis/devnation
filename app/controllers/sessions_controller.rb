class SessionsController < ApplicationController
  def new
  end

  def create
	customer = Customer.find_by_email(params[:customer][:email])
		puts customer
		if customer #&& customer.authenticate(params[:password])
	    	# Sign the user in and redirect to the user's show page.
	    	#sign_in customer
	    	session[:customer_id] = customer.id
	    	redirect_to customer
		else
	    	# Create an error message and re-render the signin form.
			flash[:error] = 'Invalid email/password combination' # Not quite right!
			render 'new'
      	end
  end

  def destroy
  	session[:customer_id] = nil
  	reset_session
	flash[:notice] = 'Logged out' # Not quite right!
	redirect_to root_url
  end
end
