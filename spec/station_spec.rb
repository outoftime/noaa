require "spec_helper"

describe NOAA::Station do
  before :all do
    NOAA::Station.stations_file = File.join(File.dirname(__FILE__), 'data', 'stations.yml')
  end

  let(:station) { NOAA::Station.find('KNYC') }

  after :all do
    NOAA::Station.stations_file = nil
  end

  it 'loads the station by id' do
    expect(NOAA::Station.find('KNYC').id).to eq 'KNYC'
  end

  describe "#closest_to" do
    it 'finds the closest to coordinates' do
      expect(NOAA::Station.closest_to(Geokit::LatLng.new(40.8, -73.96)).id)
      .to eq 'KNYC'
    end

    it 'finds the closest to lat/lng' do
      expect(NOAA::Station.closest_to(40.8, -73.96).id)
      .to eq 'KNYC'
    end

    it 'finds the closest to lat/lng passed as array' do
      expect(NOAA::Station.closest_to([40.8, -73.96]).id).to eq 'KNYC'
    end

    it 'throws the ArgumentError if bad argument passed into #closest_to()' do
      expect { NOAA::Station.closest_to('hey') }.to raise_error(ArgumentError)
    end

    it 'throws the ArgumentError if more than two arguments passed into #closest_to()' do
      expect { NOAA::Station.closest_to(1, 2, 3) }
      .to raise_error(ArgumentError)
    end
  end

  it 'returns the name' do
    expect(station.name).to eq 'New York City, Central Park'
  end

  it 'returns the state' do
    expect(station.state).to eq 'NY'
  end

  it 'returns the XML URL' do
    expect(station.xml_url).to eq 'http://weather.gov/xml/current_obs/KNYC.xml'
  end

  it 'returns the latitude' do
    expect(station.latitude).to eq 40.783
  end

  it 'returns the longitude' do
    expect(station.longitude).to eq(-73.967)
  end

  it 'returns the coordinates' do
    expect(station.coordinates).to eq Geokit::LatLng.new(40.783, -73.967)
  end
end
