class Cliente < ActiveRecord::Base
  attr_accessible :nome, :implantacao
  
  has_many :contratos
  has_many :sistemas, :through => :contratos
  
  has_many :contatos
  
  def self.buscar query=""
    where("nome like '%#{query.strip}%'").order(:nome)
  end
  
end
