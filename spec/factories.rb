FactoryGirl.define do

  factory :customer do
    first_name "Jeremy"
    last_name "Davis"
    email "jeremy.davis@redhat.com"
    password "foobar"
    password_confirmation "foobar"
  end

end