class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :player, index: true, foreign_key: true
      t.integer :winner_id
      t.json :data

      t.timestamps null: false
    end
  end
end
