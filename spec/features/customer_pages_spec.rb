require 'spec_helper'

describe "CustomerPages" do

  subject { page }

  # signup
  describe "Signup Page" do

	  before { visit signup_path } 

    it { should have_title(full_title('Signup')) } 
    it { should have_content('Signup') } 

    let(:submit) { "Signup" }

    describe "with no information" do
      it "should not create a user" do
          expect { click_button submit}.not_to change(Customer, :count)
        end
    end

    describe "without a password" do

      before do
        fill_in "First name",  with: "Bob"
        fill_in "Last name", with: "Mould"
        fill_in "Email", with: "bob@blacksheetsofrain.com"
        fill_in "Gender", with: "Male"
      end

      it "should not create a user" do
          expect { click_button submit}.not_to change(Customer, :count)
      end
    end

    describe "with valid information" do

    it "should create a user" do
        
        lambda do
          visit signup_path
          fill_in "First name",  with: "Bob"
          fill_in "Last name", with: "Mould"
          fill_in "Email", with: "bob@huskerdu.com"
          fill_in "Gender", with: "Male"
          fill_in "Password", with: "redhat-14"
          fill_in "Confirm Password", with: "redhat-14"
          click_button submit
        end.should change(Customer, :count).by(1)
      end
    end

    it "should have a welcome message after signup" do

          visit signup_path
          fill_in "First name",  with: "Grant"
          fill_in "Last name", with: "Hart"
          fill_in "Email", with: "grant@huskerdu.com"
          fill_in "Gender", with: "Male"
          fill_in "Password", with: "redhat-14"
          fill_in "Confirm Password", with: "redhat-14"
          click_button submit
          expect(page).to have_content("Welcome to DevNation Bank, Grant!")

    end


  end

  describe "Profile Page" do

    describe "customer with no accounts" do

    	let(:customer) { FactoryGirl.create(:customer) }
    	before { visit customer_path( customer ) }
    	it { should have_content(customer.first_name) }
    	it { should have_content(customer.last_name) }
      it { should have_content('Accounts') }
      it { should have_button('Add Checking Account')}
    end

    describe "customer with a CheckingAccount" do
      let(:customer) { FactoryGirl.create(:customer_with_checking_account) }
      before { visit customer_path( customer ) }
      it { should have_content(customer.first_name) }
      it { should have_content(customer.last_name) }
      it { should have_content('Accounts') }
      it { should have_button('Add Checking Account')}
      it { should have_content('Balance')}
      it { should have_link('Account Actions')}
    end
  end

end