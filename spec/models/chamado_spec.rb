# encoding: UTF-8
require 'spec_helper'

describe Chamado do
  
  describe "#relacionamentos" do
    it { should belong_to :sistema }
    it { should belong_to :contato }
    it { should belong_to :cliente }
    it { should belong_to :responsavel }
    it { should belong_to :status }
    it { should belong_to :natureza }
    it { should belong_to :criticidade }
    it { should have_one :tramite }
  end
  
  describe "#validações" do

    it "Não valida no create" do
      Chamado.create.errors.should be_empty
    end
    
    context "no Update" do
      let(:chamado){
        chamado = Chamado.create
        chamado.save
        chamado
      }
      
      it "Valida titulo" do
        chamado.errors[:titulo].should include("não pode ser branco")
      end

      it "Valida descricao" do
        chamado.errors[:descricao].should include("não pode ser branco")
      end
    end
  end
  
end
