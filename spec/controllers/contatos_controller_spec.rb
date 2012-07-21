require 'spec_helper'

describe ContatosController do

  before { login }

  describe "#por_cliente" do
    it "deve pesquisa pelo cliente informado" do
      cliente = mock("Cliente", :contatos => [])
      Cliente.should_receive(:find).with("1").and_return(cliente)
      get :por_cliente, :cliente_id => 1, :format => :json
    end

    it "deve retornar os contatos" do
      Cliente.stub_chain(:find, :contatos).and_return("dados do json")
      get :por_cliente, :cliente_id => 1, :format => :json
      
      response.body.should == "dados do json"
    end
  end


end
