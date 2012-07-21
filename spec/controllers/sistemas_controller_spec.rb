require 'spec_helper'

describe SistemasController do

  before { login }

  describe "#por_cliente" do
    it "deve pesquisa pelo cliente informado" do
      cliente = mock("Cliente", :sistemas => [])
      Cliente.should_receive(:find).with("1").and_return(cliente)
      get :por_cliente, :cliente_id => 1, :format => :json
    end

    it "deve retornar os sistemas" do
      Cliente.stub_chain(:find, :sistemas).and_return("dados do json")
      get :por_cliente, :cliente_id => 1, :format => :json
      
      response.body.should == "dados do json"
    end
  end

  describe "#contrato" do
    it "deve buscar contrato por cliente e sistema" do
      Contrato.should_receive(:find_by_cliente_id_and_sistema_id).with("1", "2").and_return("contrato json")
      get :contrato, :cliente_id => 1, :id => 2, :format => :json
      
      response.body.should == "contrato json"
    end
    
  end
end
