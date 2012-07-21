class ClientesController < ApplicationController
  
  respond_to :html, :json
  
  def index
    @clientes = Cliente.buscar params[:term]
    respond_with @clientes
  end
  
end
