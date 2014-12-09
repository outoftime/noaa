module NOAA
  class HttpService #:nodoc:
    def initialize(http = Net::HTTP)
      @HTTP = http
    end

    def get_current_conditions(station_id)
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://w1.weather.gov/xml/current_obs/#{station_id}.xml")))
    end

    def get_forecast(num_days, lat, lng)
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://w1.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=#{lat}&lon=#{lng}&format=24+hourly&numDays=#{num_days}")))
    end

    def get_station_list
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://w1.weather.gov/xml/current_obs/index.xml")))
    end
  end
end
