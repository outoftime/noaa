require File.join(File.dirname(__FILE__), 'test_helper')

class TestHttpService < NOAA::TestCase
  before :each do
    HTTP.reset
  end

  test 'should send properly-formed URL for current conditions' do
    http_service.get_current_conditions('KNYC')
    HTTP.requests.should == [URI.parse('http://www.weather.gov/xml/current_obs/KNYC.xml')]
  end

  test 'should return XML document for current conditions' do
    http_service.get_current_conditions('KNYC').to_s.should == %Q{<?xml version="1.0" encoding="UTF-8"?>\n<test/>\n}
  end

  test 'should send properly-formed URL for forecast' do
    http_service.get_forecast(4, 40.72, -73.99)
    HTTP.requests.should == [URI.parse('http://www.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=40.72&lon=-73.99&format=24+hourly&numDays=4')]
  end

  test 'should return XML document for forecast' do
    http_service.get_forecast(4, 40.72, -73.99).to_s.should == %Q{<?xml version="1.0" encoding="UTF-8"?>\n<test/>\n}
  end

  test 'should send properly-formed URL for station list' do
    http_service.get_station_list
    HTTP.requests.should == [URI.parse('http://www.weather.gov/xml/current_obs/index.xml')]
  end

  test 'should return XML document for station list' do
    http_service.get_station_list.to_s.should == %Q{<?xml version="1.0" encoding="UTF-8"?>\n<test/>\n}
  end

  private

  def http_service
    NOAA::HttpService.new(HTTP)
  end

  module HTTP
    class <<self
      def reset
        requests.clear
      end

      def requests
        @requests ||= []
      end

      def get(uri)
        requests << uri
        "<test/>"
      end
    end
  end
end
