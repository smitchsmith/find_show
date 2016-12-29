class CreateArtistEvent < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_events do |t|
      t.integer :artist_id
      t.integer :event_id

      t.timestamps
    end
  end
end
