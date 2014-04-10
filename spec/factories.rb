require 'bigdecimal'

FactoryGirl.define do

  factory :customer do
    first_name "Jeremy" 
    last_name "Davis"
    sequence(:email) { |n| "jeremy.davis#{n}@example.com" }
    password "redhat-14"
    password_confirmation "redhat-14"

	  factory :customer_with_checking_account do
      email "#{Random.rand(123456)}@example.com"
	  	after(:create) { |customer| 
        customer.checking_accounts.create(balance:1500)
      }
	  	end

    factory :customer_random do
      email "#{Random.rand(123456)}@example.com"
    end
  end



  factory :checking_account do
  	balance BigDecimal.new(1500)
  end

end