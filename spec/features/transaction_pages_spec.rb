require 'spec_helper'

describe "Transactions" do

	subject { page }

	describe "new transaction page" do

		before { visit("/transactions/new") }

		it { should have_title("DevNation Bank Transactions") }
		it { should have_content("From account") }
		it { should have_content("To account") }
		it { should have_content("Amount") }
		it { should_not have_content("Timestamp")}
		
	end


	describe "all transactions page" do

		before { visit("/transactions") }

		it { should have_title("DevNation Bank Transactions") }
		it { should have_content("From account") }
		it { should have_content("To account") }
		it { should have_content("Amount") }
		it { should have_content("Type") }

	end


end

describe "Withdrawls" do

	before { visit("/transactions/new") }

	describe "creating a withdrawl" do

		before do
			@customer = FactoryGirl.create(:customer_with_checking_account)
			fill_in("Amount", with: "100")
			choose("Withdrawl")
			fill_in("From account", with: @customer.checking_accounts[0].account_number)
		end

        it { expect { click_button("Create Transaction") }.to change(Transaction, :count) }


	end
end


