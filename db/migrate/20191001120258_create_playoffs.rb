class CreatePlayoffs < ActiveRecord::Migration[5.2]
  def change
    create_table :playoffs do |t|
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
