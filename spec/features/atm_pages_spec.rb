require 'spec_helper'

describe "ATM" do

	subject { page }

	describe "page should display form correctly" do

		before do
			visit("/atm")
		end

		it { should have_title("DevNation Bank ATM") }
		it { should have_field("Amount") }
		it { should have_content("Withdrawl") }
		it { should have_content("Deposit") }
		it { should have_button("Submit") }

	end


end

describe "ATM when logged in" do

	subject { page }
	
	describe "page should display customer's name when accessed by a logged in customer" do

		before do
			@customer = FactoryGirl.create(:customer_with_checking_account)
			sign_customer_in(@customer)
			visit("/atm")
		end

		it { should have_content("#{@customer.name}") }
		it { should have_field("Amount") }
		it { should have_content("Withdrawl") }
		it { should have_content("Deposit") }
		it { should have_button("Submit") }
	end
end




