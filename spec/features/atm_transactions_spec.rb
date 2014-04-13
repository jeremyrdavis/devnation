require 'spec_helper'

describe "ATM" do

    before {
        @customer = FactoryGirl.create(:customer_with_checking_account)
        visit signin_path
        fill_in("customer_email", with: @customer.email)
        fill_in("customer_password", with: @customer.password)
        click_button("Sign in")
    }

    it "a deposit should credit the customer's account balance" do

        visit("/atm")
        choose("Deposit")
        fill_in("Amount", with: "100")
        expect{ click_button("Submit")}.to change(Transaction, :count)
        expected_amount = BigDecimal.new(1400)
        puts "Expecting #{@customer.checking_accounts[0].balance.to_s} to eql #{expected_amount.to_s}"
        @customer.reload
        puts "Actual #{@customer.checking_accounts[0].balance.to_s} to eql #{expected_amount.to_s}"
        expect(@customer.checking_accounts[0].balance).to eql(expected_amount)

    end

    it "a withdrawl should debit the customer's account balance" do

        visit("/atm")
        choose("Withdrawl")
        fill_in("Amount", with: "100")
        expect{ click_button("Submit")}.to change(Transaction, :count)
        expected_amount = BigDecimal.new(1600)
        puts "Withdrawl Expecting #{@customer.checking_accounts[0].balance.to_s} to eql #{expected_amount.to_s}"
        @customer.reload
        puts "Withdrawl Actual #{@customer.checking_accounts[0].balance.to_s} to eql #{expected_amount.to_s}"
        expect(@customer.checking_accounts[0].balance).to eql(expected_amount)

    end

#    puts "Customer : #{@customer.inspect}"
#    it "should debit the CheckingAccount by the specified amount" do
##        @checking_account = @customer.checking_accounts[0]
#        visit("/atm")
#        fill_in("Amount", with: "100")
#        choose("Withdrawl")
#        expect { click_button("Submit") }.to change(Transaction, :count)
#        expected_balance = @checking_account.balance - 100
#        @checking_account.reload
#        expect(@checking_account.balance).to eql(expected_balance)
#    end
end





