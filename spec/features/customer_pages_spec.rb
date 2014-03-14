require 'spec_helper'

describe "CustomerPages" do

  subject { page }

  describe "Signup Page" do

	before { visit signup_path }

    it { should have_title(full_title('Signup')) } 
    it { should have_content('Signup') } 

  end

  describe "Profile Page" do

  	let(:customer) { FactoryGirl.create(:customer) }
  	before { visit customer_path( customer ) }
  	it { should have_content(customer.first_name) }
  	it { should have_content(customer.last_name) }
  end

end
