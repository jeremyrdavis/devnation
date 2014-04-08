require 'spec_helper'

describe "ATM" do

	subject { page }

	describe "ATM page should display account" do

		let(:customer) { FactoryGirl.create(:customer) }

		before do
			visit signin_path
			fill_in "Email",	with: customer.email
			fill_in "Password",	with: customer.password
			click_button "Sign in"
			visit atm_path
		end

		it { should have_title("DevNation Bank ATM") }


	end

end
