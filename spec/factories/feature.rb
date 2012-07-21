FactoryGirl.define do
  factory :feature do
  	sequence(:action) { |n| "action_#{n}"}
  	sequence(:controller) { |n| "controller_#{n}"}
    sequence(:description) { |n| "description_#{n}"}
  end
end