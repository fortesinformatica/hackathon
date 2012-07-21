FactoryGirl.define do
  factory :status do
  	sequence(:nome){ |n| "status_#{n}" }
  end
end