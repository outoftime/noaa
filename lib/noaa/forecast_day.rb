module NOAA
  #
  # A ForecastDay contains forecast data for a single day. Each day should start at 6am and
  # end at 6am the following day (assuming that is invariant on the part of the NOAA's data
  # feed). ForecastDay objects are accessed using NOAA::Forecast#[]
  class ForecastDay
    # Time when this forecast's valid time span begins
    attr_reader :starts_at

    # Time when this forecast's valid time span ends
    attr_reader :ends_at

    # High temperature for the day in Fahrenheit
    attr_reader :high

    # Low temperature for the day in Fahrenheit
    attr_reader :low

    # String summary of weather (e.g., 'Fair')
    attr_reader :weather_summary
    alias_method :weather_description, :weather_summary

    # Symbol representing NOAA weather type. See NOAA::CurrentConditions#weather_type_code
    attr_reader :weather_type_code

    # URL string for NOAA weather image
    attr_reader :image_url

    # Percentage probability of precipitation during the day, between 6am and 6pm, as an integer (0-100)
    attr_reader :daytime_precipitation_probability

    # Percentage probability of precipitation during the evening/night, between 6pm and 6am, as an integer (0-100)
    attr_reader :evening_precipitation_probability

    attr_writer :starts_at, :ends_at, :high, :low, :weather_summary, :weather_type_code, :image_url, #:nodoc:
                :daytime_precipitation_probability, :evening_precipitation_probability #:nodoc:
  end
end
