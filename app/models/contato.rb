class Contato < ActiveRecord::Base
  belongs_to :user
  belongs_to :cliente
  # attr_accessible :title, :body
end
