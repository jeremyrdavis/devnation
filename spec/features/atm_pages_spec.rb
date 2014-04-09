require 'spec_helper'

describe "ATM" do

	subject { page }
	@customer = FactoryGirl.build(:customer, email: "jeremy.davis@redhat.com")

	describe "page should display form correctly" do

		before do
			visit("/atm")
		end

		it { should have_title("DevNation Bank ATM") }
		it { should have_field("Amount") }
		it { should have_field("Withdrawl") }
		it { should have_field("Deposit") }
		it { should have_button("Submit") }

	end


end

describe "ATM when logged in" do

	subject { page }
	
	describe "page should display customer's name when accessed by a logged in customer" do

		before do
			@customer = FactoryGirl.build(:customer, email: "jeremy.davis@redhat.com")
			sign_customer_in(@customer)
			visit("/atm")
		end

		it { should have_content("#{@customer.name}") }
		it { should have_field("Amount") }
		it { should have_field("Withdrawl") }
		it { should have_field("Deposit") }
		it { should have_button("Submit") }
	end
end

describe "ATM withdrawl should increment transactions" do

		before do
			@customer = FactoryGirl.build(:customer, email: "jeremy.davis@redhat.com")
			sign_customer_in(@customer)
			visit("/atm")
			fill_in("Amount", with: "100")
			choose("Withdrawl")
		end

        it { expect { click_button "Submit"}.to change(Transaction, :count) }


end



