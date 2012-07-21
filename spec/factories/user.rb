FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@user.com"}
    password "123456"
    admin false
  end
end
