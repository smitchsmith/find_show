class ArtistEvent < ApplicationRecord
  belongs_to :artist
  belongs_to :event

  validates :artist_id, uniqueness: {scope: :event_id}
end
