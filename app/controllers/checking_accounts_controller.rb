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

  def edit
    @checking_account = CheckingAccount.find(params[:id])
    @transaction = Transaction.new
  end

  def show
    @checking_account = CheckingAccount.find(params[:id])
  end

  def make_deposit
    transaction_params = params[:transaction]
    @checking_account = CheckingAccount.find(transaction_params[:to_account])
    @transaction = Transaction.new
    @transaction.to_account_id = @checking_account.account_number
    @transaction.amount = transaction_params[:amount]
    @transaction.transaction_type = "deposit"
    @checking_account.balance += @transaction.amount

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
      if @transaction.save
        format.html { redirect_to edit_checking_account_path(@checking_account.id), notice: "Deposit was successfully made.  Your account has been credited #{@transaction.amount}" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def make_payment
    transaction_params = params[:transaction]

    @checking_account = CheckingAccount.find_by_account_number(transaction_params[:from_account])
    
    #build Transaction
    @transaction = Transaction.new
    @transaction.to_account_id = transaction_params[:to_account_id]
    @transaction.from_account_id = @checking_account.account_number
    @transaction.amount = transaction_params[:amount]
    @transaction.transaction_type = "payment"   
    @checking_account.balance = @checking_account.balance - @transaction.amount

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
        format.html { redirect_to edit_checking_account_path(@checking_account.id), notice: "Deposit was successfully made.  Your account has been credited #{@transaction.amount}" }
        format.json { head :no_content }
    end
  end

  def update
    @checking_account = CheckingAccount.find(params[:id])
    respond_to do |format|
      if @checking_account.update_attributes(checking_account_params)
        format.html { redirect_to @checking_account, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @checking_account.errors, status: :unprocessable_entity }
      end
    end
  end

    def checking_account_params
      params.require(:checking_account).permit(:balance)
    end

end
