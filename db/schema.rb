# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120713182852) do

  create_table "atendentes", :force => true do |t|
    t.string   "nome"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "atendentes", ["user_id"], :name => "index_atendentes_on_user_id"

  create_table "chamados", :force => true do |t|
    t.integer  "sistema_id"
    t.integer  "contato_id"
    t.integer  "cliente_id"
    t.integer  "responsavel_id"
    t.integer  "status_id"
    t.integer  "natureza_id"
    t.integer  "criticidade_id"
    t.string   "titulo"
    t.text     "descricao"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "chamados", ["cliente_id"], :name => "index_chamados_on_cliente_id"
  add_index "chamados", ["contato_id"], :name => "index_chamados_on_contato_id"
  add_index "chamados", ["criticidade_id"], :name => "index_chamados_on_criticidade_id"
  add_index "chamados", ["natureza_id"], :name => "index_chamados_on_natureza_id"
  add_index "chamados", ["responsavel_id"], :name => "index_chamados_on_responsavel_id"
  add_index "chamados", ["sistema_id"], :name => "index_chamados_on_sistema_id"
  add_index "chamados", ["status_id"], :name => "index_chamados_on_status_id"

  create_table "clientes", :force => true do |t|
    t.string   "nome"
    t.boolean  "implantacao", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "contatos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "cliente_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contatos", ["cliente_id"], :name => "index_contatos_on_cliente_id"
  add_index "contatos", ["user_id"], :name => "index_contatos_on_user_id"

  create_table "contratos", :force => true do |t|
    t.integer  "tempo_contratado"
    t.integer  "sistema_id"
    t.integer  "cliente_id"
    t.integer  "tipo_contrato_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "contratos", ["cliente_id"], :name => "index_contratos_on_cliente_id"
  add_index "contratos", ["sistema_id"], :name => "index_contratos_on_sistema_id"
  add_index "contratos", ["tipo_contrato_id"], :name => "index_contratos_on_tipo_contrato_id"

  create_table "features", :force => true do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "naturezas", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_features", :force => true do |t|
    t.integer  "role_id"
    t.integer  "feature_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sistemas", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "status", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tipo_contratos", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tramites", :force => true do |t|
    t.text     "descricao"
    t.integer  "tempo_cobrado",      :default => 0
    t.integer  "tempo_cronometrado", :default => 0
    t.integer  "chamado_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "tramites", ["chamado_id"], :name => "index_tramites_on_chamado_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "nome"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
