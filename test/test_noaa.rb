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

  test 'should raise ArgumentError if unknown unit specified' do
    lambda { conditions.temperature(:kelvin) }.should raise_error(ArgumentError)
  end

  private

  def conditions
    @conditions ||= NOAA::CurrentConditions.from_xml(XML_DOC)
  end
end
