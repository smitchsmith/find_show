require 'time'

class OhMyRocknessImporter
  def self.import
    OhMyRockness::Index.new.scrape.each do |data|
      event = Event.find_or_create_by!(
        date:  Time.iso8601(data[:date]),
        venue: Venue.find_or_create_by!(name: data[:venue][:name]),
      )
      event.update_attribute(:price, data[:cost])
      data[:artists].each do |artist_name|
        event.artists |= [Artist.find_or_create_by!(name: artist_name)]
      end
    end
  end
end
