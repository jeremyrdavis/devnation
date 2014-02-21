require 'spec_helper'

describe Customer do

	before { @customer = Customer.new(first_name: "Bob", last_name: "Wills", email: "bob@texasplayboys.com")}

	subject { @customer }

	it { should respond_to(:first_name)}
	it { should respond_to(:last_name)}
end