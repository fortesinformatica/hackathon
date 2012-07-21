class CreateAtendentes < ActiveRecord::Migration
  def change
    create_table :atendentes do |t|
      t.string :nome
      t.belongs_to :user
      t.timestamps
    end
    
    add_index :atendentes, :user_id
  end
end
