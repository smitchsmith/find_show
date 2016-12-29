class Artist < ActiveRecord::Base
  has_many :artist_events
  has_many :events, through: :artist_events

  validates :name, presence: true
end
