require 'spec_helper'

describe "transactions/index" do
  before(:each) do
    assign(:transactions, [
      stub_model(Transaction,
        :from_account_id => "From Account",
        :to_account_id => "To Account",
        :amount => "9.99"
      ),
      stub_model(Transaction,
        :from_account_id => "From Account",
        :to_account_id => "To Account",
        :amount => "9.99"
      )
    ])
  end

  it "renders a list of transactions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "From Account".to_s, :count => 2
    assert_select "tr>td", :text => "To Account".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
