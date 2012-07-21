# encoding: UTF-8

require 'spec_helper'

describe Cliente do
  
  describe ".buscar" do
    
    before :each do
      FactoryGirl.create(:cliente, :nome => "OCP inc")
      FactoryGirl.create(:cliente, :nome => "Stark Industries")
    end
    
    it "Deveria ordenar pelo nome" do
      Cliente.buscar.map(&:nome).should == ["OCP inc", "Stark Industries"]
    end
      
    context "Quando termo estiver vazio" do
      it "Deveria trazer todos" do
        Cliente.buscar.should have(2).clientes
      end
    end
      
    context "Quando há termo" do
      it "Deveria trazer apenas o filtrado" do
        Cliente.buscar("OCP").should have(1).cliente
      end
      
      it "Deveria filtrar usando like" do
        Cliente.buscar("OCP").first.nome.should == "OCP inc"
      end
      
      it "Deveria ignorar o CASE" do
        Cliente.buscar("ocp").first.nome.should == "OCP inc"
      end
    end
    
  end
  
end