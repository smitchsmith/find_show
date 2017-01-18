class AddOrderToArtistEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :artist_events, :order, :integer
  end
end
