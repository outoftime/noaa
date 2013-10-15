module NOAA
  # 
  # Representation of the current conditions for a given observation point.
  #
  class CurrentConditions

    class <<self
      private :new

      def from_xml(doc) #:nodoc:
        new(doc)
      end
    end

    def initialize(doc) #:notnew:
      @doc = doc
    end

    #
    # Time object containing the time at which these conditions were observed at the NOAA station
    #
    def observed_at
      @observed_at ||= Time.parse(text_from_node('observation_time_rfc822'))
    end

    #
    # Text description of the current weather conditions, e.g. "Fair"
    #
    def weather_description
      @weather_description ||= text_from_node('weather')
    end
    alias_method :weather_summary, :weather_description

    # 
    # NWS code representing weather type. This distills the #weather_description
    # into one of a much more manageable set of possibilities. Possible values are:
    #
    # - <code>:skc</code> - Clear
    # - <code>:wind</code> - Windy
    # - <code>:few</code> - A Few Clouds
    # - <code>:sct</code> - Partly Cloudy
    # - <code>:bkn</code> - Mostly Cloudy
    # - <code>:ovc</code> - Overcast
    # - <code>:ra1</code> - Light Rain
    # - <code>:ra</code> - Rain
    # - <code>:shra</code> - Rain Showers
    # - <code>:tsra</code> - Thunderstorms
    # - <code>:ip</code> - Hail
    # - <code>:fzra</code> - Freezing Rain
    # - <code>:mix</code> - Wintry Mix
    # - <code>:sn</code> - Snow
    # - <code>:fg</code> - Fog
    # - <code>:smoke</code> - Smoke
    # - <code>:dust</code> - Dust/Sand
    # - <code>:mist</code> - Haze
    # - <code>:svrtsra</code> - Tornado
    # - <code>:fzrara</code> - Freezing Rain/Rain
    # - <code>:raip</code> - Rain/Hail
    # - <code>:rasn</code> - Rain/Snow
    # - <code>:hi_shwrs</code> - Showers in Vicinity
    # - <code>:hi_tsra</code> - Thunderstorm in Vicinity
    #
    # See http://www.weather.gov/xml/current_obs/weather.php for the NWS's list of possible
    # descriptions and their type codes.
    #
    def weather_type_code
      @weather_type_code ||= text_from_node('icon_url_name').gsub(/^n|\.jpg$/, '').to_sym
    end

    # 
    # Return the NWS image URL for the current weather as string
    #
    def image_url
      @image_url ||= "#{text_from_node('icon_url_base')}#{text_from_node('icon_url_name')}"
    end

    #
    # The current temperature in the requested units.
    #
    #   conditions.temperature           #=> temperature in fahrenheit
    #   conditions.temperature(:c)       #=> temperature in celsius
    #   conditions.temperature(:kelvin)  #=> anything else raises an exception
    #
    def temperature(unit = :f)
      text_from_node_with_unit('temp', unit, :f, :c).to_i
    end

    # 
    # The current relative humidity percentage (0-100)
    #
    def relative_humidity
      text_from_node('relative_humidity').to_i
    end

    # 
    # The current cardinal or ordinal direction that the wind is coming from (e.g., "Northwest")
    #
    def wind_direction
      text_from_node('wind_dir')
    end

    # 
    # The current direction that the wind is coming from degrees (e.g. 330)
    #
    def wind_degrees
      text_from_node('wind_degrees').to_i
    end

    # 
    # The current wind speed in miles per hour as a float (e.g., 3.45)
    #
    def wind_speed
      text_from_node('wind_mph').to_f
    end

    # 
    # The current wind gust in miles per hour as a float, or nil if none
    #
    def wind_gust
      text_from_node('wind_gust_mph').to_f
    end

    # 
    # The current barometric pressure
    #
    #   conditions.pressure       #=> pressure in inches
    #   conditions.pressure(:mb)  #=> pressure in millibars
    #   conditions.pressure(:psi) #=> anything else raises an exception
    #
    def pressure(unit = :in)
      text_from_node_with_unit('pressure', unit, :in, :mb).to_f
    end

    # 
    # The current dew point.
    #
    #   conditions.dew_point           #=> dew point in fahrenheit
    #   conditions.dew_point(:c)       #=> dew point in celsius
    #   conditions.dew_point(:kelvin)  #=> anything else raises an exception
    #
    def dew_point(unit = :f)
      text_from_node_with_unit('dewpoint', unit, :f, :c).to_i
    end

    # 
    # The current heat index
    #
    #   conditions.heat_index           #=> heat index in fahrenheit
    #   conditions.heat_index(:c)       #=> heat index in celsius
    #   conditions.heat_index(:kelvin)  #=> anything else raises an exception
    #
    def heat_index(unit = :f)
      text_from_node_with_unit('heat_index', unit, :f, :c).to_i
    end

    # 
    # The current wind chill
    #
    #   conditions.wind_chill           #=> wind chill in fahrenheit
    #   conditions.wind_chill(:c)       #=> wind chill in celsius
    #   conditions.wind_chill(:kelvin)  #=> anything else raises an exception
    #
    def wind_chill(unit = :f)
      text_from_node_with_unit('windchill', unit, :f, :c).to_i
    end

    # 
    # The current visibility in miles
    #
    def visibility
      text_from_node('visibility_mi').to_f
    end

    private

    def text_from_node(element_name)
      @doc.find("/current_observation/#{element_name}[1]/child::text()").first.to_s
    end

    def text_from_node_with_unit(element_name, unit, *allowed_units)
      raise ArgumentError, "Unknown unit #{unit.inspect} - allowed units are #{allowed_units.inspect}" unless allowed_units.include?(unit)
      text_from_node("#{element_name}_#{unit}")
    end
  end
end
