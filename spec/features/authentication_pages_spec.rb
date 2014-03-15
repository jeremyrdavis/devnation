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


  end
end
