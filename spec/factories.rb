require 'bigdecimal'

FactoryGirl.define do

  factory :customer do
    first_name "Jeremy"
    last_name "Davis"
    email "jeremy.davis" + Random.rand(1234).to_s + "@redhat.com"
    password "redhat-14"
    password_confirmation "redhat-14"

	  factory :customer_with_checking_account do
      account_number = Random.rand(12345678)
	  	after(:create) { |customer| 
        customer.checking_accounts.create(balance:1500)
      }
	  	end
  end


  factory :checking_account do
  	account_number "DVNCA1234567"
  	balance BigDecimal.new(1500)
  end



end