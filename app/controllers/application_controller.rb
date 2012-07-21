class ApplicationController < ActionController::Base
  layout "external"
  
  protect_from_forgery
  before_filter :authenticate_user!, :authorize_user!
  skip_filter :authorize_user!, :if => lambda {|controller| !user_signed_in?}
  
  before_filter :only => :destroy do |controller|
    Rails.cache.delete current_user.key_cache if controller.is_a? Devise::SessionsController
  end
  
  def authorize_user!        
    if !is_a?(DeviseController) && current_user.cannot?(self.controller_name, self.action_name)
      render :text => 'Sem acesso'
    end
  end
  
end
