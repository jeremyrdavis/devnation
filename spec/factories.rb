FactoryGirl.define do

  factory :user do
    name     "Jeremy Davis"
    email    "jeremy.davis@redhat.com"
    password "foobar"
    password_confirmation "foobar"
  end

end