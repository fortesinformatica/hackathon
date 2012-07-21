class CreateTramites < ActiveRecord::Migration
  def change
    create_table :tramites do |t|
      t.text :descricao
      t.integer :tempo_cobrado, :default => 0
      t.integer :tempo_cronometrado, :default => 0
      t.belongs_to :chamado
      t.timestamps
    end
    
    add_index :tramites, :chamado_id
    
  end
end
