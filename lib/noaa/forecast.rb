module NOAA
  #
  # A Forecast object represents a multi-day forecast for a particular place. The forecast for a given day can
  # be accessed using the [] method; e.g. (assuming +forecast+ is a forecast for 12/20/2008 - 12/24/2008):
  #
  #   forecast[1]     #=> ForecastDay for 12/21/2008
  #   forecast.length #=> 4
  #
  class Forecast

    class <<self
      private :new

      def from_xml(doc) #:nodoc:
        new(doc)
      end
    end

    def initialize(doc) #:noinit:
      @doc = doc
    end

    #
    # The number of days provided by the forecast
    #
    def length
      @length ||= @doc.find(%q{/dwml/data/time-layout[@summarization='24hourly'][1]/start-valid-time}).length
    end

    #
    # Get the ForecastDay for day i
    #
    #   forecast[1] #=> returns the ForecastDay for the second day
    #
    def [](i)
      forecast_days[i]
    end

    private

    def forecast_days
      @forecast_days ||= begin
        days = []
        length.times do |i|
          days << day = NOAA::ForecastDay.new
          day.starts_at = starts[i]
          day.ends_at = ends[i]
          day.high = maxima[i]
          day.low = minima[i]
          day.weather_summary = weather_summaries[i]
          day.weather_type_code = weather_type_codes[i]
          day.image_url = image_urls[i]
          day.daytime_precipitation_probability = precipitation_probabilities[i*2]
          day.evening_precipitation_probability = precipitation_probabilities[i*2+1]
        end
        days
      end
    end

    def starts
      @starts ||= @doc.find(%q{/dwml/data/time-layout[@summarization='24hourly'][1]/start-valid-time/text()}).map do |node|
        Time.parse(node.to_s)
      end
    end

    def ends
      @ends ||= @doc.find(%q{/dwml/data/time-layout[@summarization='24hourly'][1]/end-valid-time/text()}).map do |node|
        Time.parse(node.to_s)
      end
    end

    def maxima
      @maxima ||= @doc.find(%q{/dwml/data/parameters[1]/temperature[@type='maximum'][@units='Fahrenheit'][1]/value/text()}).map do |node|
        node.to_s.to_i
      end
    end

    def minima
      @minima ||= @doc.find(%q{/dwml/data/parameters[1]/temperature[@type='minimum'][@units='Fahrenheit'][1]/value/text()}).map do |node|
        node.to_s.to_i
      end
    end

    def weather_summaries
      @weather_summaries ||= @doc.find(%q{/dwml/data/parameters[1]/weather[1]/weather-conditions}).map do |node|
        node['weather-summary'].to_s
      end
    end

    def image_urls
      @image_urls ||= @doc.find(%q{/dwml/data/parameters[1]/conditions-icon/icon-link/text()}).map do |node|
        node.to_s
      end
    end

    def weather_type_codes
      @weather_type_codes ||= image_urls.map do |url|
        url.match(/n?([a-z_]+)\d*\.jpg$/)[1].to_sym
      end
    end

    def precipitation_probabilities
      @precipitation_probabilities ||= @doc.find(%q{/dwml/data/parameters[1]/probability-of-precipitation[1]/value/text()}).map do |node|
        node.to_s.to_i
      end
    end
  end
end
