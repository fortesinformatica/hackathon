# encoding: UTF-8
FactoryGirl.define do
  factory :contrato do
    tempo_contratado 3600
  
    association :sistema
    association :cliente
    association :tipo_contrato
  end
end