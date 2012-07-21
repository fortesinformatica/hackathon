class CreateTipoContratos < ActiveRecord::Migration
  def change
    create_table :tipo_contratos do |t|
      t.string :nome
      
      t.timestamps
    end
  end
end
