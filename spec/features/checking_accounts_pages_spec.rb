require 'spec_helper'


describe "CheckingAccountsPages" do

	subject{ page }
	
	# Create a customer for the tests
	before { @customer = FactoryGirl.create(:customer_with_checking_account) }

	# Creating a CheckingAccount doesn't have an actual page.  The CheckingAccountsController
	# creates the account and forwards back to the originating Customer page
	describe "create from the Customer page" do
		before { visit customer_path( @customer ) }
        it { should have_button("Add Checking Account") }
		it "should create a CheckingAccount" do
		  expect { click_button "Add Checking Account"}.to change(CheckingAccount, :count)
		end
	end

    it "should have a welcome message after signup" do
		visit customer_path( @customer )
		click_button "Add Checking Account"
		expect(page).to have_content("Checking account was successfully created!")

    end

	it "CheckingAccount should be editable" do
		visit customer_path(@customer)
		click_link("Account Actions")
		expect(page).to have_content("Account #{@customer.checking_accounts[0].account_number}")
		expect(page).to have_content("Make Deposit")
		expect(page).to have_content("Make Payment")
	end

	it "should be able to make a deposit" do
		visit customer_path(@customer)
		click_link("#{@customer.checking_accounts[0].id}_actions")
		options = {:with => "500"}
		fill_in("deposit_amount", options)
		expect { click_button "Make Deposit"}.to change(Transaction, :count)
	end

end
