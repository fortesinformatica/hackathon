class CreateContatos < ActiveRecord::Migration
  def change
    create_table :contatos do |t|
      t.belongs_to :user
      t.belongs_to :cliente

      t.timestamps
    end
    add_index :contatos, :user_id
    add_index :contatos, :cliente_id
  end
end
