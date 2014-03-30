       require 'spec_helper'

describe Customer do

	before { @customer = Customer.new(email: "bob@texasplayboys.com", first_name: "Bob", last_name: "Wills", password: "redhat-14", password_confirmation: "redhat-14")}
	subject { @customer }

	it { should respond_to(:first_name)}
	it { should respond_to(:last_name)}
	it { should respond_to(:email)}
	it { should respond_to(:password_digest)}
	it { should respond_to(:password)}
	it { should respond_to(:password_confirmation)}
	it { should respond_to(:authenticate)}
	it { should respond_to(:checking_accounts)}
	it { should be_valid }

	# validations
	it "should not be valid without email" do
		Customer.new(first_name: "Bob", last_name: "Wills", password: "redhat-14", password_confirmation: "redhat-14").should_not be_valid
	end
	it "should not be valid without first_name" do
		Customer.new(last_name: "Wills", email: "bob@texasplayboys", password: "redhat-14", password_confirmation: "redhat-14").should_not be_valid
	end
	it "should not be valid without last_name" do
		Customer.new(first_name: "Bob", email: "bob@texasplayboys", password: "redhat-14", password_confirmation: "redhat-14").should_not be_valid
	end
	it "should not be valid withou a password and a password_confirmation" do
		Customer.new(first_name: "Bob", last_name: "Wills", email: "bob@texasplayboys").should_not be_valid
	end
	it "should not be valid when the password and password_confirmation don't match" do
		Customer.new(first_name: "Bob", email: "bob@texasplayboys", password: "redhat-14", password_confirmation: "bar").should_not be_valid
	end


	# check for email validity
	it "should contain a valid email address" do
		customer = Customer.new(first_name: "Bob", last_name: "Wills")
		addresses = %w[user@redhat-14,com user_at_redhat-14.com redhat-14.com user@ user@redhat-14 user@redhat-14_bar.com user@redhat-14+bar.com]
		addresses.each do |invalid_address|
			customer.email = invalid_address
			expect(customer).not_to be_valid
		end
	end

	it "should be valid when the email address is valid" do
		customer = Customer.new(first_name: "Bob", last_name: "Wills", password: "redhat-14", password_confirmation: "redhat-14")
		addresses = %w[user@redhat-14.com user_@redhat-14.com _user@redhat-14.com user@redhat-14.org user@redhat-14.it user@redhat-14.gov]
		addresses.each do |valid_address|
			customer.email = valid_address
			expect(customer).to be_valid
		end
	end


	describe "should not be valid when email address is already taken" do
		before do
			customer_with_same_email = @customer.dup
			customer_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "email should always be downcased before save" do
		customer2 = Customer.create(first_name: "Eldon", last_name: "Shamblin", email: "eldon@TEXASPLAYBOYS.COM", password: "redhat-14", password_confirmation: "redhat-14").save
		c3 = Customer.find_by_first_name("Eldon")
		#c3.email.should == "eldon@texasplayboys.com"
	end

	# authentication tests
	describe "return value of authentication method" do
		  before { @customer.save }
		  let(:found_customer) { Customer.find_by(email: @customer.email) }
	
		describe "with valid password" do
			it { should eq found_customer.authenticate(@customer.password) }
		end

		describe "with invalid password" do
			let(:customer_for_invalid_password) { found_customer.authenticate("invalid") }

			it { should_not eq customer_for_invalid_password }
			specify { expect(customer_for_invalid_password).to be_false }
		end
	end

	describe "with a password that is too short" do
		before{ @customer.password = "a" * 5 }
		it { should_not be_valid }
	end



end