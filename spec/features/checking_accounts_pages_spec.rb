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
		checking_account = @customer.checking_accounts[0]
		click_link("#{checking_account.id}_actions")

		options = {:with => "500"}
		fill_in("deposit_amount", options)
		expect { click_button "Make Deposit"}.to change(Transaction, :count)
		transaction = Transaction.last
		expect { transaction.to_account.to eq checking_accounts.account_number}
		expect { transaction.amount.to eq 500}
		expect { transaction.transaction_type.to eq "deposit"}
	end

	it "should be able to make a Payment" do

		pay_to_account = "PTA123456789"

		visit customer_path(@customer)
		checking_account = @customer.checking_accounts[0]
		expect { checking_account.to_not be_nil }
		click_link("#{checking_account.id}_actions")
		fill_in("payment_amount", with: 500)
		fill_in("to_account", with: pay_to_account)

		expect { click_button "Make Payment"}.to change(Transaction, :count)
		transaction = Transaction.last
		expect(transaction.to_account_id).to eq(pay_to_account)
		expect(transaction.from_account_id).to eq(checking_account.account_number)
		expect(transaction.amount).to eq 500
		expect(transaction.transaction_type).to eq "payment"
	end


end
