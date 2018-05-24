begin
  require 'time'
  require 'nokogiri'
  require 'geokit'
  require 'libxml'
rescue LoadError => e
  if require 'rubygems' then retry
  else raise(e)
  end
end

%w(current_conditions forecast forecast_day http_service station station_writer).each { |file| require File.join(File.dirname(__FILE__), 'noaa', file) }

# 
# The NOAA singleton provides methods to conveniently access information from the NOAA weather feed.
# For the most part, NOAA.current_conditions and NOAA.forecast will be the only entry point into the
# NOAA API you will need; one exception is discussed below.
#
module NOAA
  autoload :VERSION, File.join(File.dirname(__FILE__), 'noaa', 'version')

  class <<self
    # 
    # Retrieve the current weather conditions for a given latitude and longitude. Returns an
    # instance of NOAA::CurrentConditions.
    #
    #   NOAA.current_conditions(37.989, -77.507)  #=> NOAA::CurrentConditions encapsulating current conditions at this point
    #
    # <b>Note:</b> This method parses the stored list of all weather stations in the US and then finds the closest one to
    # the given coordinates, as the NOAA XML API only takes a weather station ID as input. Clearly, this is an expensive
    # operation; if your application needs to repeatedly request conditions for the same point, you will be much better off
    # determining the current station once using NOAA::Station.closest_to, storing the station ID, and then passing it into
    # NOAA.current_conditions_at_station when you need to get the latest conditions.
    #
    def current_conditions(lat, lng)
      current_conditions_at_station(Station.closest_to(lat, lng).id)
    end
    
    # 
    # Retrieve the current weather conditions for a given weather station ID. Returns an
    # instance of NOAA::CurrentConditions.
    #
    #   NOAA.current_conditions_at_station('KNYC')  #=> NOAA::CurrentConditions encapsulating current conditions in Central Park
    #
    # See discussion above regarding why this method is often preferable to simply calling #current_conditions.
    #
    def current_conditions_at_station(station_id)
      CurrentConditions.from_xml(HttpService.new.get_current_conditions(station_id))
    end

    # 
    # Retrieve daily forecast information for a given latitude and longitude. Returns
    # an instance of NOAA::Forecast.
    #
    #   NOAA.forecast(4, 37.989, -77.507)  #=> NOAA::Forecast containing next four days of forecast data for given coordinates
    #
    # <b>Note:</b> The NOAA updates this data no more than once an hour, and asks that users of the API not request the forecast
    # for a given location more frequently than that. For more information, please see http://www.nws.noaa.gov/xml/#frequency
    #
    def forecast(num_days, lat, lng)
      Forecast.from_xml(HttpService.new.get_forecast(num_days, lat, lng))
    end
  end
end
