module Sync
  class Spotify < Struct.new(:user)
    def sync(destructive = false)
      if destructive
        user.artists = playlist_artists
      else
        user.artists |= playlist_artists
      end
    end

    private

    def playlist_artists
      Artists.new(self).artists
    end
  end

  class Artists < SimpleDelegator
    def artists
      found_artists | not_found_artists
    end

    private

    def not_found_artists
      @not_found_artists ||= spotify_artists.map do |spotify_artist|
        next unless not_found_ids.include?(spotify_artist.id)
        if (named_artist = Artist.find_by(name: spotify_artist.name)).present?
          named_artist.tap { named_artist.update_attribute(:spotify_id, spotify_artist.id) }
        else
          Artist.create!(name: spotify_artist.name, spotify_id: spotify_artist.id)
        end
      end.compact
    end

    def found_artists
      @found_artists ||= Artist.where(spotify_id: spotify_artist_ids)
    end

    def not_found_ids
      @not_found_ids ||= spotify_artist_ids - found_artists.pluck(:spotify_id)
    end

    def spotify_artists
      @spotify_artists ||= user.spotify_client.owned_playlists.flat_map(&:tracks).flat_map(&:artists).uniq
    end

    def spotify_artist_ids
      @spotify_artist_ids ||= spotify_artists.map(&:id)
    end
  end
end
