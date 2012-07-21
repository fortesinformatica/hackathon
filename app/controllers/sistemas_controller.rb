class SistemasController < ApplicationController
  
  respond_to :html, :json
  
  def por_cliente
    respond_with Cliente.find( params[:cliente_id] ).sistemas
  end

  def contrato
    respond_with Contrato.find_by_cliente_id_and_sistema_id(params[:cliente_id], params[:id]), :methods => [:tempo_contratado_fmt, :tempo_usado_fmt, :tempo_restante_fmt]
  end
end
