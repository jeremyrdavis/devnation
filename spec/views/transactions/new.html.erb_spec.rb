require 'spec_helper'

describe "transactions/new" do
  before(:each) do
    assign(:transaction, stub_model(Transaction,
      :from_account_id => "MyString",
      :to_account_id => "MyString",
      :amount => "9.99"
    ).as_new_record)
  end

  it "renders new transaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transactions_path, "post" do
      assert_select "input#transaction_from_account_id[name=?]", "transaction[from_account_id]"
      assert_select "input#transaction_to_account_id[name=?]", "transaction[to_account_id]"
      assert_select "input#transaction_amount[name=?]", "transaction[amount]"
    end
  end
end
