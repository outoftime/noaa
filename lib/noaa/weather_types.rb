module NOAA
  module WeatherTypes
    MATCHERS = [[/^Showers in Vicinity( (Fog(\/Mist)?|Haze))?$/i, :hi_shwrs],
                [/^Haze$/, :mist],
                [/(^Breezy|Windy)$/, :wind],
                [/^Mostly Cloudy/i, :bkn],
                [/^(Fair|Clear)/i,  :skc],
                [/^A Few Clouds/i,  :few],
                [/^Partly Cloudy/i, :sct],
                [/^Overcast/i,      :ovc],
                [/^(Tornado|Funnel Cloud)/i, :nsvrtsra],
                [/^(Showers |Thunderstorm |Snow |Light |Heavy |Low Drifting |Blowing |in Vicinity )*Snow( Grains| Showers| in Vicinity| Fog(\/Mist)?)*$/i, :sn],
                [/^Thunderstorm Ice Pellets$/i, :ip],
                [/^Thunderstorm in Vicinity( Fog| Haze)?$/i, :hi_tsra],
                [/^(Light |Heavy )?Thunderstorm/i, :tsra],
                [/^(Light Rain|(Light |Heavy )?Drizzle)( Fog(\/Mist)?)?$/i, :ra1],
                [/^(Heavy )?Rain( Fog(\/Mist)?)?$/, :ra],
                [/^(Light |Heavy )?(Showers )?Rain( Showers)?( and Breezy)?( in Vicinity)?( Fog\/Mist)?$/i, :shra],
                [/Fog/i,            :fg],
                [/^Smoke$/i,        :smoke],
                [/^(Light |Heavy )?(Freezing (Rain|Drizzle)|(Rain|Drizzle) Freezing) (Rain|Drizzle)$/, :fzrara],
                [/Snow Freezing (Rain|Drizzle)|Freezing (Rain|Drizzle) Snow/i, :mix],
                [/Freezing (Rain|Drizzle)/i, :fzra],
                [/(Rain|Drizzle) Ice Pellets|Ice Pellets (Rain|Drizzle)/i, :raip],
                [/Ice (Pellets|Crystals)|Hail/i, :ip],
                [/(Rain|Drizzle) Snow|Snow (Rain|Drizzle)/i, :rasn],
                [/Dust|Sand/, :dust]]

    class <<self
      def code_for(description)
        MATCHERS.each do |expression, code|
          return code if description =~ expression
        end
        nil
      end
    end
  end
end
