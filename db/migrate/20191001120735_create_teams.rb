class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.references :division, foreign_key: true

      t.timestamps
    end
  end
end
