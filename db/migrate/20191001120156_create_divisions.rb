class CreateDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :divisions do |t|
      t.string :name, null: false
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
