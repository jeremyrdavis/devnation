require 'bigdecimal'
require 'faker'

FactoryGirl.define do

  sequence :email do |n|
    "#{Random.rand(123456)}#{n}@factory.com"
  end

  factory :customer do
    first_name Faker::Name.first_name 
    last_name Faker::Name.last_name
    email
    password "redhat-14"
    password_confirmation "redhat-14"

	  factory :customer_with_checking_account do
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