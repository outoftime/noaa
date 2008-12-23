require File.join(File.dirname(__FILE__), 'test_helper')

class TestNOAA < NOAA::TestCase
  include LibXML
  XML_DOC = XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'KVAY.xml'))

  test 'should return observation time' do
    conditions.observed_at.should == Time.parse('2008-12-23 10:54:00 -0500')
  end

  test 'should return weather description' do
    conditions.weather_description.should == 'Fair'
  end

  test 'should return temperature in fahrenheit by default' do
    conditions.temperature.should == 24
  end

  test 'should return temperature in fahrenheit when specified' do
    conditions.temperature(:f).should == 24
  end

  test 'should return temperature in celsius when specified' do
    conditions.temperature(:c).should == -4
  end

  test 'should raise ArgumentError if unknown unit specified for temperature' do
    lambda { conditions.temperature(:kelvin) }.should raise_error(ArgumentError)
  end

  test 'should return relative humidity' do
    conditions.relative_humidity.should == 52
  end

  test 'should return wind direction' do
    conditions.wind_direction.should == 'Northwest'
  end

  test 'should return wind degrees' do
    conditions.wind_degrees.should == 330
  end

  test 'should return wind speed in MPH' do
    conditions.wind_speed.should == 3.45
  end

  test 'should return wind gust in MPH' do
    conditions.wind_gust.should == 10.25
  end

  #TODO wind gust can be NA
  
  test 'should return pressure in inches by default' do
    conditions.pressure.should == 30.7
  end

  test 'should return pressure in inches when specified' do
    conditions.pressure(:in).should == 30.7
  end

  test 'should return pressure in millibars when specified' do
    conditions.pressure(:mb).should == 1039.5
  end

  test 'should throw ArgumentError when unrecognized pressure specified for pressure' do
    lambda { conditions.pressure(:psi) }.should raise_error(ArgumentError)
  end

  test 'should return dew point in fahrenheit by default' do
    conditions.dew_point.should == 9
  end

  test 'should return dew point in fahrenheit when specified' do
    conditions.dew_point(:f).should == 9
  end

  test 'should return dew point in celsius when specified' do
    conditions.dew_point(:c).should == -13
  end

  test 'should throw ArgumentError when unrecognized unit specified for dew point' do
    lambda { conditions.dew_point(:kelvin) }.should raise_error(ArgumentError)
  end

  #TODO heat index can be NA

  test 'should return heat index in fahrenheit by default' do
    conditions.heat_index.should == 105
  end

  test 'should return heat index in fahrenheit when specified' do
    conditions.heat_index(:f).should == 105
  end

  test 'should return heat index in celsius when specified' do
    conditions.heat_index(:c).should == 41
  end

  test 'should throw ArgumentError when unrecognized unit specified for heat index' do
    lambda { conditions.heat_index(:kelvin) }.should raise_error(ArgumentError)
  end

  #TODO wind chill can be NA

  test 'should return wind chill in fahrenheit by default' do
    conditions.wind_chill.should == 19
  end

  test 'should return wind chill in fahrenheit when specified' do
    conditions.wind_chill(:f).should == 19
  end

  test 'should return wind chill in celsius when specified' do
    conditions.wind_chill(:c).should == -7
  end

  test 'should throw ArgumentError when unrecognized unit specified for wind chill' do
    lambda { conditions.wind_chill(:kelvin) }.should raise_error(ArgumentError)
  end

  test 'should return visibility in miles' do
    conditions.visibility.should == 10.0
  end

  private

  def conditions
    @conditions ||= NOAA::CurrentConditions.from_xml(XML_DOC)
  end
end
