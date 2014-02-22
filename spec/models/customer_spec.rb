require 'spec_helper'

describe Customer do

	before { @customer = Customer.new(email: "bob@texasplayboys.com", first_name: "Bob", last_name: "Wills")}
	subject { @customer }

	it { should respond_to(:first_name)}
	it { should respond_to(:last_name)}
	it { should respond_to(:email)}
	it { should be_valid }

	# validations
	it "should not be valid without email" do
		Customer.new(first_name: "Bob", last_name: "Wills").should_not be_valid
	end
	it "should not be valid without first_name" do
		Customer.new(last_name: "Wills", email: "bob@texasplayboys").should_not be_valid
	end
	it "should not be valid without last_name" do
		Customer.new(first_name: "Bob", email: "bob@texasplayboys").should_not be_valid
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