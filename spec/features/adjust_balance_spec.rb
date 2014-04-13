require 'spec_helper.rb'

describe "Adjusting the balance from the CheckingAccount page" do

    before {
        @customer = FactoryGirl.create(:customer_with_checking_account, 
            first_name: "Frank", 
            last_name: "Black", 
            email: "frank.black@pixies.com",
            gender: "male")
    }

    it "should update the customer's account balance" do

        @checking_account = @customer.checking_accounts[0]
        visit edit_checking_account_path(@checking_account)
        fill_in("checking_account_balance", with: "5000")
        click_button("Adjust Balance")
        puts "Expecting #{@customer.checking_accounts[0].balance.to_s} to eql 5000"
        @checking_account.reload
        expect(@checking_account.balance).to eql(BigDecimal.new(5000))

    end

end