# encoding: UTF-8
require 'spec_helper'

describe ChamadosHelper do
  describe "#atendente_logado" do
    
    context "Quando houver usuário logado" do
      before { @user = FactoryGirl.create(:user, :admin => true) }
      
      context "e houver atendente vinculado" do        
        before { @atendente = FactoryGirl.create(:atendente, :user => @user) }

        it "deve retornar o atendente" do
          helper.stub(:current_user).and_return(@user)
          helper.atendente_logado.should == @atendente
        end
      end
      
    end
    
    context "Quando NÃO houver usuário logado" do
    end
    
  end
end
