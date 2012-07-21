class ContatosController < ApplicationController

  respond_to :html, :json
  
  def por_cliente
    respond_with Cliente.find( params[:cliente_id] ).contatos, :include => :user
  end

end