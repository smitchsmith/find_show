class UserArtist < ApplicationRecord
  include Activateable

  belongs_to :user
  belongs_to :artist

  validates :user, :artist, presence: true
  validates :user, uniqueness: {scope: :artist}

  delegate :name, to: :artist, prefix: true
end
