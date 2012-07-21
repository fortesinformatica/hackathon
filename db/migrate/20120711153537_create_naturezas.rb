class CreateNaturezas < ActiveRecord::Migration
  def change
    create_table :naturezas do |t|
      t.string :nome

      t.timestamps
    end
  end
end
