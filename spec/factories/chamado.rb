# encoding: UTF-8
FactoryGirl.define do
  factory :chamado do
  	sequence(:titulo){ |n| "chamado_#{n}" }
    descricao "descrição do chamado"
  end
end