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

  def create
  	logger.debug { params }
  	transaction_params = params["transaction"]
  	logger.debug { transaction_params }

  	transaction_type = transaction_params["transaction_type"]
  	transaction_amount = transaction_params["amount"]

  	logger.debug { "transaction_type: #{transaction_type}" }
  	logger.debug { "transaction_amount: #{transaction_amount}" }

    @transaction = Transaction.new()
    @transaction.amount = transaction_amount
    @transaction.transaction_type = transaction_type
    @transaction
    logger.debug(@transaction)

    @customer = view_context.current_customer
    # temporary
    @checking_account = @customer.checking_accounts[0]
    logger.debug { "CheckingAccount : #{@checking_account.inspect}" }
    
    if(transaction_type == "withdrawl")
    	@transaction.from_account_id = @checking_account.account_number
    elsif (transaction_type == "withdrawl")
    	@transaction.to_account_id = @checking_account.account_number
    end

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to "/atm", notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { redirect_to "/atm", notice: 'Transaction error.' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end


end
