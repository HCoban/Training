class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id, null: false, index: true
      t.string :title, null: false
      t.text :lyrics
      t.timestamps null: false
    end
  end
end
