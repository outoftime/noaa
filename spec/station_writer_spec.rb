require 'spec_helper'

describe NOAA do
  describe NOAA::StationWriter do
    let(:xml_document) { LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'stations-abridged.xml')) }

    before do
      io = StringIO.new
      NOAA::StationWriter.new(xml_document).write(io)
      @yaml = YAML.load(io.string)
    end

    it "writes the latitude for each station" do
      [40.66, 40.77, 40.783].each_with_index do |latitude, i|
        expect(@yaml[i]['latitude']).to eq latitude
      end
    end

    it "writes the longitude for each station" do
      [-73.78, -73.9, -73.967].each_with_index do |longitude, i|
        expect(@yaml[i]['longitude']).to eq longitude
      end
    end

    it "writes the id for each station" do
      ['KJFK', 'KLGA', 'KNYC'].each_with_index do |id, i|
        expect(@yaml[i]['id']).to eq id
      end
    end

    it "writes the name for each station" do
      ['New York/John F. Kennedy Intl Airport', 'New York, La Guardia Airport', 'New York City, Central Park'].each_with_index do |name, i|
        expect(@yaml[i]['name']).to eq name
      end
    end

    it "writes the state for each station" do
      (%w(NY) * 3).each_with_index do |state, i|
        expect(@yaml[i]['state']).to eq state
      end
    end

    it "writes the XML URL for each station" do
      3.times do |i|
        expect(@yaml[i]['xml_url']).to eq "http://weather.gov/xml/current_obs/#{@yaml[i]['id']}.xml"
      end
    end
  end
end
