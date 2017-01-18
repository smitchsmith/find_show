class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :timeoutable,
         omniauth_providers: [:spotify]

  serialize :spotify_data, Hash

  has_many :user_artists, dependent: :destroy
  has_many :artists, through: :user_artists

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email        = auth.info.email
      user.password     = Devise.friendly_token[0,20]
      user.name         = auth.info.name
      user.spotify_data = RSpotify::User.new(auth).to_hash
      user.skip_confirmation!
    end
  end

  def spotify_client
    @spotify_client ||= SpotifyClient.new(self)
  end

  def followed_artist_events
    Event.joins(:artist_events).where("artist_events.artist_id IN (?)", artist_ids).uniq
  end
end
