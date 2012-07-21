# encoding: UTF-8
require 'spec_helper'

describe ChamadosController do

  before { login }

  describe "#index" do
    it "deveria retornar todos os chamados" do
      chamados = [ mock('Chamado') ]
      Chamado.stub(:all).and_return(chamados)
      
      get :index
      assigns[:chamados].should == chamados
    end
    
    it "deveria buscar todos os chamados, sem filtros" do
      Chamado.should_receive(:all)
      
      get :index
    end    
  end

  describe "#edit" do
    let(:chamado){
      FactoryGirl.build(:chamado, :tramite => Tramite.new)
    }
    it "deveria retornar o chamado de id passado" do
      Chamado.stub(:find).with('1').and_return(chamado)
      
      get :edit, :id => 1
      assigns[:chamado].should == chamado
    end
    
    it "deveria buscar um chamado pelo id informado" do
      Chamado.should_receive(:find).with('1').and_return(chamado)
      
      get :edit, :id => 1
    end    

    it "deveria criar um trâmite novo" do
      chamado.tramite = nil
      tramite = FactoryGirl.build(:tramite, :chamado => chamado)

      Chamado.stub(:find).with('1').and_return(chamado)    
      Tramite.stub(:new).and_return(tramite)
      
      get :edit, :id => 1
      assigns[:chamado].tramite.should == tramite
    end
  end

  describe "#create" do
    before(:each) do
      Chamado.stub!(:new).and_return(@chamado = mock_model(Chamado, :save=>true))
    end
    
    it "deveria criar um chamado" do
      Chamado.should_receive(:new).and_return(@chamado)
      do_create
    end

    it "deveria salvar o chamado" do
      @chamado.should_receive(:save).and_return(true)
      do_create
    end
  end
  
  describe "#update" do
    before do
      @chamado = mock_model(Chamado, :id => 1)
      Chamado.stub(:find).and_return(@chamado)
    end
  
    context "quando conseguiu atualizar" do
      before {@chamado.stub(:update_attributes!)}
      it "deveria direcionar para listagem de chamados" do
        put :update, :id => 1
        response.should redirect_to(chamados_path)
      end
    end
    
    
    
    context "quando ocorreu erro na atualização" do
      before {@chamado.stub(:update_attributes!).and_raise(Exception.new("erro"))}
      it "deveria exibir mensagem de erro" do   
        put :update, :id => 1
        flash[:notice].should == "erro"
      end
      
      it "deveria redirecionar para a tela de edição" do
        put :update, :id => 1
        response.should redirect_to(edit_chamado_path(1))
      end
    end
  
  
  end
  
  def do_create
    post :create, :chamado => {"titulo"=>"TITULO","descricao"=>"DESCRICAO"}
  end  
end
