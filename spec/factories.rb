FactoryGirl.define do
  factory :user do
    name                      "Micky Mouse"
    email                     "mick@fooc.us"
    password                  "foobar"
    password_confirmation     "foobar"

  end


  factory :task do
    content "Lorem ipsum"
    user
  end
end