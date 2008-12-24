require File.join(File.dirname(__FILE__), 'test_helper')

class TestStationWriter < NOAA::TestCase
  XML_DOC = LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'stations-abridged.xml'))

  [40.66, 40.77, 40.783].each_with_index do |latitude, i|
    test "should write latitude for station #{i}" do
      yaml[i]['latitude'].should == latitude
    end
  end

  [-73.78, -73.9, -73.967].each_with_index do |longitude, i|
    test "should write longitude for station #{i}" do
      yaml[i]['longitude'].should == longitude
    end
  end

  ['KJFK', 'KLGA', 'KNYC'].each_with_index do |id, i|
    test "should write id for station #{i}" do
      yaml[i]['id'].should == id
    end
  end

  ['New York/John F. Kennedy Intl Airport', 'New York, La Guardia Airport', 'New York City, Central Park'].each_with_index do |name, i|
    test "should write name for station #{i}" do
      yaml[i]['name'].should == name
    end
  end

  (%w(NY) * 3).each_with_index do |state, i|
    test "should write state for station #{i}" do
      yaml[i]['state'].should == state
    end
  end

  3.times do |i|
    test "should write XML URL for station #{i}" do
      yaml[i]['xml_url'].should == "http://weather.gov/xml/current_obs/#{yaml[i]['id']}.xml"
    end
  end

  def yaml
    @yaml ||= begin
      io = StringIO.new
      NOAA::StationWriter.new(XML_DOC).write(io)
      YAML.load(io.string)
    end
  end
end
