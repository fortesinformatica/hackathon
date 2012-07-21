class Tramite < ActiveRecord::Base
  attr_accessible :descricao, :tempo_cobrado, :tempo_cronometrado
  
  belongs_to :chamado
end
