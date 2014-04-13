require 'spec_helper.rb'

describe "Payments from the CheckingAccount page" do

    before {
        @customer = FactoryGirl.create(:customer_with_checking_account, 
            first_name: "Frank", 
            last_name: "Black", 
            email: "frank.black@pixies.com",
            gender: "male")
    }

    it "should update the customer's account balance" do

        visit edit_checking_account_path(@customer.checking_accounts[0])
        fill_in("to_account", with: "ABC123456789")
        fill_in("payment_amount", with: "100")
        expect{ click_button("Make Payment")}.to change(Transaction, :count)
        expected_amount = BigDecimal.new(1400)
        puts "Expecting #{@customer.checking_accounts[0].balance.to_s} to eql #{expected_amount.to_s}"
        @customer.reload
        expect(@customer.checking_accounts[0].balance).to eql(expected_amount)

    end

end