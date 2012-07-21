FactoryGirl.define do
  factory :atendente do
  	sequence(:nome){ |n| "atendente_#{n}" }
  end
end