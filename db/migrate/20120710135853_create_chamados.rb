class CreateChamados < ActiveRecord::Migration
  def change
    create_table :chamados do |t|

      t.belongs_to :sistema
      t.belongs_to :contato
      t.belongs_to :cliente
      t.belongs_to :responsavel 
      t.belongs_to :status
      t.belongs_to :natureza
      t.belongs_to :criticidade 

      t.string :titulo
      t.text :descricao

      t.timestamps
    end
    add_index :chamados, :sistema_id
    add_index :chamados, :contato_id
    add_index :chamados, :cliente_id
    add_index :chamados, :responsavel_id
    add_index :chamados, :status_id
    add_index :chamados, :natureza_id
    add_index :chamados, :criticidade_id
  end
end
