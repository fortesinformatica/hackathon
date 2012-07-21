class Atendente < ActiveRecord::Base
  attr_accessible :nome
  
  belongs_to :user
end
