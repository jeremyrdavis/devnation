require 'spec_helper'

describe "transactions/show" do
  before(:each) do
    @transaction = assign(:transaction, stub_model(Transaction,
      :from_account_id => "From Account",
      :to_account_id => "To Account",
      :amount => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/From Account/)
    rendered.should match(/To Account/)
    rendered.should match(/9.99/)
  end
end
