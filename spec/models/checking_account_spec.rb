require 'spec_helper'

describe CheckingAccount do

	# create a Customer for the CheckingAccount
	let(:customer) { FactoryGirl.create(:customer) }

	before do
		@checking_account = CheckingAccount.new(balance: 1000, customer_id: customer.id)
	end

	subject { @checking_account }

	it { should respond_to(:balance) }
	it { should respond_to(:customer_id) }
	it { should respond_to(:account_number) }

	
end