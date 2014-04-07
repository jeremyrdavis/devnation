require 'spec_helper'


describe "CheckingAccountsPages" do

	subject{ page }
	
	# Create a customer for the tests
	before { @customer = FactoryGirl.create(:customer)}

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

#    describe "should show current balance" do
#		# Create a customer for the tests
#		before { @customer = FactoryGirl.create(:customer_with_checking_account)}
#		vist checking_account_path( @customer.checking_accounts(0) )
#		expect(page).to have_content("Balance:")
#   end

end
