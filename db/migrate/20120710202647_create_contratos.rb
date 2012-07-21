class CreateContratos < ActiveRecord::Migration
  def change
    create_table :contratos do |t|
      t.integer    :tempo_contratado
      t.belongs_to :sistema
      t.belongs_to :cliente
      t.belongs_to :tipo_contrato
      
      t.timestamps
    end
    add_index :contratos, :sistema_id
    add_index :contratos, :cliente_id
    add_index :contratos, :tipo_contrato_id
  end
end
