module NOAA
  class CurrentConditions

    class <<self
      private :new

      #
      # Create a CurrentConditions instance using from an XML document
      #
      # === Parameters
      #
      # +doc+:: LibXML::XML::Document containing the NOAA's current_obs response
      #
      # === Returns
      #
      # CurrentConditions object representing data in XML response
      #
      def from_xml(doc)
        new(doc)
      end
    end

    # :notnew:
    def initialize(doc)
      @doc = doc
    end

    #
    # Returns a Time object containing the time at which these conditions were observed at the NOAA station
    #
    def observed_at
      @observed_at ||= Time.parse(text_from_node('observation_time_rfc822'))
    end

    #
    # Returns a text description of the current weather conditions, e.g. "Fair"
    #
    def weather_description
      @weather_description ||= text_from_node('weather')
    end

    #
    # Returns the current temperature in the requested units.
    #
    # === Parameters
    #
    # +unit+:: Either :f (Fahrenheit) or :c (Celsius). Other arguments will throw an exception.
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
    # === Parameters:
    #
    # +unit+:: Either :in (inches) or :mb (millibars). Other arguments will throw an exception.
    #
    def pressure(unit = :in)
      text_from_node_with_unit('pressure', unit, :in, :mb).to_f
    end

    # 
    # The current dew point
    #
    # === Parameters:
    #
    # +unit+:: Either :f (fahrenheit) or :c (celsius). Other arguments will throw an exception.
    #
    def dew_point(unit = :f)
      text_from_node_with_unit('dewpoint', unit, :f, :c).to_i
    end

    # 
    # The current heat index
    #
    # === Parameters:
    #
    # +unit+:: Either :f (fahrenheit) or :c (celsius). Other arguments will throw an exception.
    #
    def heat_index(unit = :f)
      text_from_node_with_unit('heat_index', unit, :f, :c).to_i
    end

    # 
    # The current wind chill
    #
    # === Parameters:
    #
    # +unit+:: Either :f (fahrenheit) or :c (celsius). Other arguments will throw an exception.
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

    #
    # Extract the first text element from the first node in the document
    #
    # === Parameters
    #
    # +element_name+:: Name of the element to extract text from
    # 
    # === Returns
    #
    # String containing first text node of the first instance of the named element
    #
    def text_from_node(element_name)
      @doc.find("/current_observation/#{element_name}[1]/child::text()").first.to_s
    end

    def text_from_node_with_unit(element_name, unit, *allowed_units)
      raise ArgumentError, "Unknown unit #{unit.inspect} - allowed units are #{allowed_units.inspect}" unless allowed_units.include?(unit)
      text_from_node("#{element_name}_#{unit}")
    end
  end
end
