require 'bigdecimal'

FactoryGirl.define do

  factory :customer do
    first_name "Jeremy"
    last_name "Davis"
    email "jeremy.davis@redhat.com"
    password "redhat-14"
    password_confirmation "redhat-14"

	  factory :customer_with_checking_account do
	  	after_create do |customer| 
        customer.checking_accounts.create(account_number: "DVNCA1234567", balance: BigDecimal.new("1500"))
	  	end
	  end
  end


  factory :checking_account do
  	account_number "DVNCA1234567"
  	balance BigDecimal.new(1500)
  end



end