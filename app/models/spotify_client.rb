class SpotifyClient < Struct.new(:user)
  def owned_playlists
    @owned_playlists ||= all_playlists.select { |playlist| playlist.owner.id == client.id }
  end

  def all_playlists
    @all_playlists ||= all(:playlists)
  end

  private

  def all(method, limit = 50, offset = 0)
    if (collection = client.send(method, limit: limit, offset: offset)).empty?
      return collection
    else
      collection += all(method, limit, offset + limit)
    end
  end

  def client
    @client ||= RSpotify::User.new(user.spotify_data)
  end
end
