require 'rails_helper'

describe Sync::Spotify do
  context '.sync' do
    let(:spotify_artists) do
      [
        {name: "Royal Headache", id: "a1"},
        {name: "Cleaners", id: "a2"},
        {name: "Slow Warm Death", id: "a3"}
      ].map { |artist| OpenStruct.new(artist) }
    end

    let(:original_artists) do
      [Artist.create!(name: "Posse"), Artist.create!(name: "Black Marble", spotify_id: "a4")]
    end

    let(:no_id_artist) { Artist.create!(name: "Tony Molina") }

    let(:user) do
      User.create!(email: "foo@findshow.xyz", password: "faffle", artists: original_artists) { |user| user.skip_confirmation! }
    end

    before do
      allow_any_instance_of(::Sync::Spotify::Artists).to receive(:spotify_artists)
        .and_return(spotify_artists)
    end

    it "should remove a user's artists when destructive => true" do
      described_class.new(user).sync(true)
      expect(user.artists & original_artists).to be_blank
    end

    it "should keep a user's artists when destructive => false" do
      described_class.new(user).sync
      expect(user.artists & original_artists).to be_present
    end

    it "should add a spotify_id to an artist without one" do
      allow_any_instance_of(::Sync::Spotify::Artists).to(receive(:spotify_artists)).and_return([no_id_artist])
      described_class.new(user).sync
      expect(no_id_artist.reload.spotify_id).to be_present
    end

    it "should create an artist if one doesn't exist" do
      described_class.new(user).sync
      expect(Artist.find_by(name: spotify_artists.first.name)).to be_present
    end
  end
end
