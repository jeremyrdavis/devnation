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
  	transaction_params = params["transaction"]

  	transaction_type = transaction_params["transaction_type"]
  	transaction_amount = transaction_params["amount"]
    puts "TransactionType : #{transaction_type}"

    @transaction = Transaction.new()
    @transaction.amount = transaction_amount
    @transaction.transaction_type = transaction_type

    @customer = view_context.current_customer
    # temporary
    @checking_account = @customer.checking_accounts[0]
    
    if(transaction_type == "withdrawl")
    	@transaction.from_account_id = @checking_account.account_number
    elsif (transaction_type == "deposit")
    	@transaction.to_account_id = @checking_account.account_number
    end

    if(transaction_type == "withdrawl")
      @checking_account.withdraw(@transaction.amount)
    elsif (transaction_type == "deposit")
      @checking_account.deposit(@transaction.amount)
    end

    puts "New balance : #{@checking_account.balance.to_s}"

    begin
      @transaction.transaction do
        success = @transaction.save!
        success = @checking_account.save!      
      end 
      # on error return the error pae
      rescue => e
        respond_to do |format|
            format.html { render action: 'edit' }
            format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      return
    end

    respond_to do |format|
        format.html { redirect_to "/atm", notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
    end
  end

end
