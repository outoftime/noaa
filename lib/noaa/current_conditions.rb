module NOAA
  class CurrentConditions

    class <<self
      private :new

      # Create a CurrentConditions instance using from an XML document
      #
      # === Parameters
      #
      # +doc+:: LibXML::XML::Document containing the NOAA's current_obs response
      #
      # === Returns
      #
      # CurrentConditions object representing data in XML response
      def from_xml(doc)
        new(:observed_at => Time.parse(doc.find('/current_observation/observation_time_rfc822[1]/child::text()').first.to_s),
            :weather_description => doc.find('/current_observation/weather[1]/child::text()').first.to_s,
            :temp_f => doc.find('/current_observation/temp_f/child::text()').first.to_s.to_i,
            :temp_c => doc.find('/current_observation/temp_c/child::text()').first.to_s.to_i)
      end
    end

    attr_reader :observed_at, :weather_description

    def initialize(params = {})
      params.each_pair do |name, value|
        instance_variable_set(:"@#{name}", value)
      end
    end

    def temperature(unit = :f)
      case unit
      when :f then @temp_f
      when :c then @temp_c
      else raise(ArgumentError, "Unknown unit #{unit.inspect} - allowed units are :f and :c")
      end
    end

  end
end
