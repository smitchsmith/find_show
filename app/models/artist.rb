class Artist < ActiveRecord::Base
  has_many :artist_events
  has_many :events, through: :artist_events

  validates :name, presence: true
  validates :spotify_id, uniqueness: true, allow_blank: true
end
