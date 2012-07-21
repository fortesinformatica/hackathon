# encoding: UTF-8
class Chamado < ActiveRecord::Base
  attr_accessible :sistema_id, 
                  :contato_id, 
                  :cliente_id, 
                  :titulo, 
                  :descricao,
                  :responsavel_id, 
                  :status_id,
                  :natureza_id,
                  :tramite_attributes
  
  belongs_to :sistema 
  belongs_to :contato
  belongs_to :cliente
  belongs_to :responsavel, :class_name => 'Atendente'
  belongs_to :status
  belongs_to :natureza
  belongs_to :criticidade
  
  has_one :tramite, :dependent => :destroy

  accepts_nested_attributes_for :tramite
  
  validates :titulo, :descricao, :presence => {:message => "não pode ser branco"}, :on => :update
end
