class User < ActiveRecord::Base
  has_many :users_roles, :class_name => "UsersRoles"
  has_many :roles, :through => :users_roles
  
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :admin, :password_confirmation, :remember_me
  
  def can? controller, action
    admin? || cached_actions.include?([controller, action])
  end
  
  def cannot? controller, action
    !can? controller, action
  end
  
  def key_cache
    "#{email}_allowed_actions"
  end

private  
  def cached_actions
    write_on_cache
    Rails.cache.read key_cache
  end
  
  def write_on_cache
    Rails.cache.write key_cache, allowed_actions unless Rails.cache.exist? key_cache
  end
  
  def allowed_actions
    roles.includes(:features).map{|x| x.features}.flatten.map{|x| [x.controller, x.action]}
  end

end
