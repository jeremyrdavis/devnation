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

