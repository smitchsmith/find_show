class UserArtist < ApplicationRecord
  belongs_to :user
  belongs_to :artist

  validates :user, :artist, presence: true
  validates :user, uniqueness: {scope: :artist}
end
