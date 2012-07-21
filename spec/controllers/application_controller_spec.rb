# encoding: UTF-8
require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      render :text => "index called"
    end  
    
    def destroy
      render :text => "destroy called"
    end  
  end
  
  describe "Quando estiver logado" do
    before { login }
  
    describe "DELETE 'destroy'" do
      context "Quando o controller for Devise::SessionsController" do
        it "Deve apagar a session do usuário" do
          controller.stub(:is_a?).and_return(true)
          Rails.cache.should_receive(:delete)
          delete :destroy, :id => 1
        end
      end
  
      context "Quando o controller for Devise::SessionsController" do
        it "Não deve apagar a session do usuário" do
          controller.stub(:is_a?).and_return(false)
          Rails.cache.should_receive(:delete).never
          delete :destroy, :id => 1
        end
      end    
    end
  
    describe "#authorize_user!" do
      context "Quando for uma ação do devise" do
        before { controller.stub(:is_a?).with(DeviseController).and_return(true) }
        it "NÃO deve validar" do
          User.any_instance.should_receive(:cannot?).never
          get :index
        end
      end
      
      context "Quando NÃO for uma ação do devise" do    
        before { controller.stub(:is_a?).with(DeviseController).and_return(false) }
        it "deve validar" do
          User.any_instance.should_receive(:cannot?).with(anything, 'index').once
          get :index
        end
        
        context "Quando NÃO for autorizado" do
          it "deve retornar erro de 'Sem Acesso'" do
            User.any_instance.stub(:cannot?).with(anything, 'index').and_return(true)
            get :index
            response.body.should == 'Sem acesso'
          end
        end
      end
    end
  
  end
  
  describe "Quando NÃO estiver logado" do
    it "não deve autorizar" do
      controller.should_receive(:authorize_user!).never
      get :index
    end
  end
end