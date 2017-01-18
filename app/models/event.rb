class Event < ApplicationRecord
  belongs_to :venue
  has_many :artist_events
  has_many :artists, -> { order("artist_events.order") }, through: :artist_events

  delegate :name, to: :venue, prefix: true

  def add_artist_with_order(artist, order)
    artist_event = artist_events.find_or_create_by!(artist_id: artist.id)
    artist_event.update_attribute(:order, order) unless artist_event.order == order
  end

  def artist_names
    artists.pluck(:name).uniq
  end
end
