require 'spec_helper'

describe Customer do

	before { @customer = Customer.new(first_name: "Bob", last_name: "Wills", email: "bob@texasplayboys.com")}

	subject { @customer }

	it { should respond_to(:first_name)}
	it { should respond_to(:last_name)}
	it { should respond_to(:email)}

	# validations
	it { should be_valid }

	describe "first_name is required" do
		before { @customer.first_name = "" }
		it { should_not be_valid }
	end

	describe "last_name is required" do
		before { @customer.last_name = "" }
		it { should_not be_valid }
	end

	describe "email is required" do
		before { @customer.email = "" }
		it { should_not be_valid }
	end

end