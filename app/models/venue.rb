class Venue < ActiveRecord::Base
  has_many :events

  validates :name, presence: true
end
