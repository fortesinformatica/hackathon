FactoryGirl.define do
  factory :natureza do
  	sequence(:nome){ |n| "natureza_#{n}" }
  end
end