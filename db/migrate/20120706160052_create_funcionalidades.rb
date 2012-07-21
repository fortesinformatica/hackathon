class CreateFuncionalidades < ActiveRecord::Migration
  def change
    create_table :funcionalidades do |t|
      t.string :controlador
      t.string :acao
      t.string :descricao

      t.timestamps
    end
  end
end
