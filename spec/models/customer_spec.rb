       require 'spec_helper'

describe Customer do

	before { @customer = Customer.new(email: "bob@texasplayboys.com", first_name: "Bob", last_name: "Wills", password: "foo", password_confirmation: "foo")}
	subject { @customer }

	it { should respond_to(:first_name)}
	it { should respond_to(:last_name)}
	it { should respond_to(:email)}
	it { should respond_to(:password_digest)}
	it { should respond_to(:password)}
	it { should respond_to(:password_confirmation)}
	it { should be_valid }

	# validations
	it "should not be valid without email" do
		Customer.new(first_name: "Bob", last_name: "Wills", password: "foo", password_confirmation: "foo").should_not be_valid
	end
	it "should not be valid without first_name" do
		Customer.new(last_name: "Wills", email: "bob@texasplayboys", password: "foo", password_confirmation: "foo").should_not be_valid
	end
	it "should not be valid without last_name" do
		Customer.new(first_name: "Bob", email: "bob@texasplayboys", password: "foo", password_confirmation: "foo").should_not be_valid
	end
	it "should not be valid withou a password and a password_confirmation" do
		Customer.new(first_name: "Bob", last_name: "Wills", email: "bob@texasplayboys").should_not be_valid
	end
	it "should not be valid when the password and password_confirmation don't match" do
		Customer.new(first_name: "Bob", email: "bob@texasplayboys", password: "foo", password_confirmation: "bar").should_not be_valid
	end


	# check for email validity
	it "should contain a valid email address" do
		customer = Customer.new(first_name: "Bob", last_name: "Wills")
		addresses = %w[user@foo,com user_at_foo.com foo.com user@ user@foo user@foo_bar.com user@foo+bar.com]
		addresses.each do |invalid_address|
			customer.email = invalid_address
			expect(customer).not_to be_valid
		end
	end

	it "should be valid when the email address is valid" do
		customer = Customer.new(first_name: "Bob", last_name: "Wills", password: "foo", password_confirmation: "foo")
		addresses = %w[user@foo.com user_@foo.com _user@foo.com user@foo.org user@foo.it user@foo.gov]
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
		customer2 = Customer.new(first_name: "Eldon", last_name: "Shamblin", email: "eldon@TEXASPLAYBOYS.COM").save
		c3 = Customer.find_by_first_name("Eldon")
		c3.email.should == "eldon@texasplayboys.com"
	end

end