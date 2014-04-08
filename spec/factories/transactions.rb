# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    from_account_id "MyString"
    to_account_id "MyString"
    amount "9.99"
    timestamp "2014-04-07 21:28:24"
  end
end
