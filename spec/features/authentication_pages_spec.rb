require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin page" do

		before { visit signin_path }

		it { should have_content('Sign in')}
		it { should have_title(full_title('Sign in'))}

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_selector('div.alert.alert-error') }
			it { should have_content('Invalid email/password combination')}
		end

		# make sure flash error message doesn't hang around too long
		describe "after visiting another page" do
		  before { click_link "Home" }
		  it { should_not have_selector('div.alert.alert-error') }
		end

		describe "with valid information" do

			let(:customer) { FactoryGirl.create(:customer) }

			before do
				fill_in "Email",	with: customer.email
				fill_in "Password",	with: customer.password
				click_button "Sign in"
			end

			it { should have_title(customer.name)}
			#it { should have_link('Profile',     href: user_path(user)) }
			it { should have_link('Sign Out',    href: signout_path) }
			#it { should_not have_link('Sign in', href: signin_path) }
		end

  end


end
