class CreateUserGrupo < ActiveRecord::Migration
  def up
    create_table :users_grupos do |t|
      t.integer :user_id
      t.integer :grupo_id

      t.timestamps
    end
  end

  def down
    drop_table :users_grupos
  end
end
