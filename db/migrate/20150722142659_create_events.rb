class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :github_id
      t.json :github_data

      t.timestamps null: false
    end
  end
end
