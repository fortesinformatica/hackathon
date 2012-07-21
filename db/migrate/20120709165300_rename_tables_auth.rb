class RenameTablesAuth < ActiveRecord::Migration
  def change
    rename_table :funcionalidades, :features
    rename_table :grupos, :roles
    rename_table :users_grupos, :users_roles
    rename_table :grupos_funcionalidades, :roles_features
    
    rename_column :features, :controlador, :controller
    rename_column :features, :acao, :action
    rename_column :features, :descricao, :description
    
    rename_column :roles, :nome, :name
    
    rename_column :users_roles, :grupo_id, :role_id
    
    rename_column :roles_features, :grupo_id, :role_id
    rename_column :roles_features, :funcionalidade_id, :feature_id
  end
end