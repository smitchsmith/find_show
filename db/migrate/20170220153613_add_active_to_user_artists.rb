class AddActiveToUserArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :user_artists, :active, :boolean, default: true
  end
end
