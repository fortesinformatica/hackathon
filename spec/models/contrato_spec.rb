# encoding: UTF-8
require 'spec_helper'

describe Contrato do

  describe "#tempo_contratado_fmt" do
    it "deve retornar o tempo_contratado em segundos no formato HH:MM:SS" do
      contrato = Contrato.new(:tempo_contratado => 10891)
      contrato.tempo_contratado_fmt.should == "03:01:31"
    end
  end

  context "Calculos de tempo usado e saldo" do
    before :each do
      cliente = FactoryGirl.create(:cliente, :nome => "Guanabara")

      ag = FactoryGirl.create(:sistema, :nome => "AG")
      ac = FactoryGirl.create(:sistema, :nome => "AC")

      @contrato_ag = FactoryGirl.create(:contrato, :tempo_contratado => 240, :cliente => cliente, :sistema => ag)
      @contrato_ac = FactoryGirl.create(:contrato, :tempo_contratado => 300, :cliente => cliente, :sistema => ac)
      
      chamado_ag = FactoryGirl.create(:chamado, :cliente => cliente, :sistema => ag)
      chamado_ac = FactoryGirl.create(:chamado, :cliente => cliente, :sistema => ac)
      
      tramite_ag = FactoryGirl.create(:tramite, :chamado => chamado_ag, :tempo_cobrado => 100)
      tramite_ac = FactoryGirl.create(:tramite, :chamado => chamado_ac, :tempo_cobrado => 320)
    end
    
    describe "#tempo_usado" do
      it "deve retornar o tempo usado" do
        @contrato_ag.tempo_usado.should == 100
      end
    end

    describe "#tempo_usado_fmt" do
      it "deve retornar o tempo usado formatada" do
        @contrato_ag.tempo_usado_fmt.should == "00:01:40"
      end
    end

    describe "#tempo_restante" do
      it "deve retornar o tempo restante positivo" do
        @contrato_ag.tempo_restante.should == 140
      end

      it "deve retornar o tempo restante negativo" do
        @contrato_ac.tempo_restante.should == -20
      end
    end

    describe "#tempo_restante_fmt" do
      it "deve retornar o tempo restante positivo" do
        @contrato_ag.tempo_restante_fmt.should == "00:02:20"
      end

      it "deve retornar ZERO se tempo restante negativo" do
        @contrato_ac.tempo_restante_fmt.should == "00:00:00"
      end
    end
  end
    
end
