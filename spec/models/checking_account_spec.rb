require 'spec_helper'

describe CheckingAccount do

	# create a Customer for the CheckingAccount
	let(:customer) { FactoryGirl.create(:customer) }

	before { @checking_account = Customer.checking_account.build(balance: 1000)  }

	subject { @checking_account }

	it { should respond_to(:balance) }
	it { should respond_to(:customer) }
	its(:customer) { should eq :customer }
	it { should respond_to(:account_number) }

	describe "without a customer_id" do
		before { @checking_account.customer_id = nil }
		it { should_not be_valid }
	end

	
end