require 'rails_helper'

describe OhMyRocknessImporter do
  context '.import' do
    let(:data) do
      {
        date:    "2016-12-28T20:00:00-05:00",
        artists: ["Band", "Band"],
        venue:   {name: "Outside", link: "foo.com"},
        cost:    "Free"
      }
    end

    before do
      allow_any_instance_of(OhMyRockness::Index).to receive(:scrape)
        .and_return([data])
    end

    it 'should create an Event' do
      expect { described_class.import }.to change { Event.count }.by(1)
    end

    it "shouldn't create duplicate artist entries" do
      described_class.import
      expect(Event.first.artists.count).to be(1)
    end
  end
end
