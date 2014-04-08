require 'spec_helper'

describe "transactions/edit" do
  before(:each) do
    @transaction = assign(:transaction, stub_model(Transaction,
      :from_account_id => "MyString",
      :to_account_id => "MyString",
      :amount => "9.99"
    ))
  end

  it "renders the edit transaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do
      assert_select "input#transaction_from_account_id[name=?]", "transaction[from_account_id]"
      assert_select "input#transaction_to_account_id[name=?]", "transaction[to_account_id]"
      assert_select "input#transaction_amount[name=?]", "transaction[amount]"
    end
  end
end
