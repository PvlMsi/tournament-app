class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :first_team_id
      t.integer :second_team_id
      t.integer :winning_team_id
      t.integer :parent_id, null: false
      t.string :parent_type, null: false
      t.integer :sub_match_id
      t.integer :round

      t.timestamps
    end
  end
end
