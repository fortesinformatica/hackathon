require 'spec_helper'

describe ClientesController do
  
  before { login }

  describe "GET 'index'" do
    
    context "Quando o formato for json" do
      
      it "Deveria listar pelo termo" do
        Cliente.should_receive(:buscar).with("OCP")
        get :index, :format => :json, :term => "OCP" 
      end
      
    end
    

  end
  
end
