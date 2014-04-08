require 'spec_helper'

describe "ATM" do

	subject { page }
	@customer = FactoryGirl.create(:customer)

	describe "page should display form correctly" do

		before do
			visit("/atm")
		end

		it { should have_title("DevNation Bank ATM") }
		it { should have_content("Amount") }
		it { should have_content("Withdrawl") }
		it { should have_content("Deposit") }
		it { should have_content("Submit") }

	end

	describe "page should display customer's name when accessed by a logged in customer" do

		before do
			signin_customer(@customer)
			visit("/atm")
			it { should have_content("#{customer.name}") }

		end

	end

end
