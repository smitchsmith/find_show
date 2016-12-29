class ArtistEvent < ActiveRecord::Base
  belongs_to :artist
  belongs_to :event

  validates :artist_id, uniqueness: {scope: :event_id}
end
