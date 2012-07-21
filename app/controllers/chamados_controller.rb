class ChamadosController < ApplicationController
  layout "application"
  respond_to :html

  def index
    @chamados = Chamado.all
  end

  def edit
    @chamado = Chamado.find params[:id]
    @chamado.tramite = Tramite.new if @chamado.tramite == nil
    @chamado_json = @chamado.to_json(:only => [:sistema_id, :contato_id, :cliente_id, :titulo, :descricao,:responsavel_id, :status_id, :natureza_id,])
  end
  
  def adicionar_tramite
    @chamado = Chamado.find params[:id]
    @chamado.tramite = Tramite.new if @chamado.tramite == nil
    @chamado_json = @chamado.to_json(:only => [:sistema_id, :contato_id, :cliente_id, :titulo, :descricao,:responsavel_id, :status_id, :natureza_id,])
  end
  
  def create
    @chamado = Chamado.new
    @chamado.save
    redirect_to edit_chamado_path @chamado
  end
  
  def update 
    begin 
      @chamado = Chamado.find params[:id]
      @chamado.update_attributes! params[:chamado]
     
      redirect_to chamados_path
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to edit_chamado_path @chamado
    end
  end  
end
