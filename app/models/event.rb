class Event < ApplicationRecord
  belongs_to :venue
  has_many :artist_events
  has_many :artists, through: :artist_events

  delegate :name, to: :venue, prefix: true

  def artist_names
    artists.pluck(:name).uniq
  end
end
