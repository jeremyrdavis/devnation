class CheckingAccountsController < ApplicationController

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.find(params[:customer_id])
    @account = @customer.checking_accounts.create()

    # return back to the Customer's page
    respond_to do |format|
      if @account
        flash[:success] = "Welcome to DevNation Bank, #{@customer.first_name}!"
        format.html { redirect_to @customer, notice: 'Checking account was successfully created!' }
        format.json { render action: 'show', status: :created, location: @customer }
      else
        format.html { render action: 'show', location: @customer }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end
  

end
