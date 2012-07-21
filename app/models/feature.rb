class Feature < ActiveRecord::Base
  attr_accessible :action, :controller, :description
  
  has_many :roles_features, :class_name => "RolesFeatures"
  has_many :roles, :through => :roles_features
end
