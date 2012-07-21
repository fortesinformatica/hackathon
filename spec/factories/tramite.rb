# encoding: UTF-8
FactoryGirl.define do
  factory :tramite do
    descricao "Descrição do Trâmite"
    tempo_cobrado 240
    tempo_cronometrado 360
    
    association :chamado
  end
end