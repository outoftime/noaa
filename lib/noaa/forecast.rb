module NOAA
  class Forecast

    class <<self
      private :new

      def from_xml(doc)
        new(doc)
      end
    end

    # :noinit:
    def initialize(doc)
      @doc = doc
    end

    def length
      @length ||= @doc.find(%q{/dwml/data/time-layout[@summarization='24hourly'][1]/start-valid-time}).length
    end

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
  end
end
