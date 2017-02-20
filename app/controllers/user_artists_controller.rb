class UserArtistsController < ApplicationController
  def index
    @props = {userArtists: serialized_user_artists}
  end

  def activation
    user_artist = UserArtist.find(params[:id])
    user_artist.update_attribute(:active, params[:user_artist][:active])
    render :json => serialize(user_artist)
  end

  private

  def serialized_user_artists
    current_user.user_artists.joins(:artist).order("artists.name").map do |user_artist|
      serialize(user_artist)
    end
  end

  def serialize(user_artist)
    user_artist
      .as_json(methods: :artist_name)
      .merge(activation_url: activation_user_artist_url(user_artist))
  end
end
