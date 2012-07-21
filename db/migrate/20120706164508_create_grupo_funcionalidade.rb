class CreateGrupoFuncionalidade < ActiveRecord::Migration
  def up
    create_table :grupos_funcionalidades do |t|
      t.integer :grupo_id
      t.integer :funcionalidade_id

      t.timestamps
    end
  end

  def down
    drop_table :grupos_funcionalidades
  end
end
