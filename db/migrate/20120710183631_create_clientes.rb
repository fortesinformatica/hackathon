class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nome
      t.boolean :implantacao, :default => false

      t.timestamps
    end
  end
end
