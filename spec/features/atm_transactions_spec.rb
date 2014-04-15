require 'spec_helper'

describe "ATM" do

    before(:each) do
        @customer = FactoryGirl.create(:customer_with_checking_account)
        visit signin_path
        fill_in("customer_email", with: @customer.email)
        fill_in("customer_password", with: @customer.password)
        click_button("Sign in")
    end

    it "a deposit should credit the customer's account balance" do
        expect(@customer.checking_accounts[0].balance).to eql(BigDecimal.new(1500))
        visit("/atm")
        choose("transaction_transaction_type_deposit")
        fill_in("Amount", with: "100")
        expect{ click_button("Submit")}.to change(Transaction, :count)
        expected_amount = BigDecimal.new(1600)
        @customer.reload
        expect(@customer.checking_accounts[0].balance).to eql(expected_amount)

    end

    it "a withdrawl should debit the customer's account balance" do
        expect(@customer.checking_accounts[0].balance).to eql(BigDecimal.new(1500))
        visit("/atm")
        choose("Withdrawl")
        fill_in("Amount", with: "100")
        expect{ click_button("Submit")}.to change(Transaction, :count)
        expected_amount = BigDecimal.new(1400)
        @customer.reload
        expect(@customer.checking_accounts[0].balance).to eql(expected_amount)

    end

end





