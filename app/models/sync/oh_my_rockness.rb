require 'time'

module Sync
  class OhMyRockness
    def self.import
      ::OhMyRockness::Index.new.scrape.each do |data|
        event = Event.find_or_create_by!(
          date:  Time.iso8601(data[:date]),
          venue: Venue.find_or_create_by!(name: data[:venue][:name]),
        )
        event.update_attributes(price: data[:cost], tickets_link: data[:tickets_url])
        data[:artists].each do |artist_data|
          artist = Artist.find_or_create_by!(name: artist_data[:name])
          event.add_artist_with_order(artist, artist_data[:order])
        end
      end
    end
  end
end
