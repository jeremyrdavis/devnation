require 'spec_helper.rb'

describe "Payments from the CheckingAccount page" do

    before {
        @customer = FactoryGirl.create(:customer_with_checking_account)
    }

    it "should update the customer's account balance" do

        visit edit_checking_account_path(@customer.checking_accounts[0])
        fill_in("deposit_amount", with: "100")
        expect{ click_button("Make Deposit")}.to change(Transaction, :count)
        expected_amount = BigDecimal.new(1600)
        @customer.reload
        expect(@customer.checking_accounts[0].balance).to eql(expected_amount)

    end

end