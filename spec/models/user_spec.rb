# encoding: UTF-8
require 'spec_helper'

describe User do
  before do
    Rails.cache.clear
  end
  
  describe "#can?" do
    let(:usuario){
      feature1 = FactoryGirl.create(:feature, :action => 'index', :controller => 'people')
      feature2 = FactoryGirl.create(:feature, :action => 'edit', :controller => 'people')
      role = FactoryGirl.create(:role, :name => 'cadastradores', :features => [feature1, feature2])
      FactoryGirl.create(:user, :roles => [role])
    }
    
    context "usuário com acesso à feature" do
      it "usuário deve ter permissão de acesso à listar pessoas" do        
        usuario.can?('people', 'index').should be_true
      end

      it "usuário deve ter permissão de acesso à editar pessoas" do        
        usuario.can?('people', 'edit').should be_true
      end
    end
    
    context "usuário sem acesso à feature" do
      it "usuário deve ter permissão de acesso à listar pessoas" do
        usuario.can?('people', 'new').should be_false
      end
    end
    
    context "como admin" do
      it "usuário deve ter permissão de acesso à listar pessoas" do
        usuario = FactoryGirl.create(:user, :admin => true)
        usuario.can?('people', 'new').should be_true
      end
    end
  end
  
  describe "#cannot?" do    
    let(:usuario){
      FactoryGirl.create(:user)
    }
    
    context "deve negar o can?" do
      it {
        usuario.stub(:can?).and_return(true)
        usuario.cannot?('people', 'index').should be_false
      }

      it {
        usuario.stub(:can?).and_return(false)
        usuario.cannot?('people', 'index').should be_true
      }      
    end
  end
  
end