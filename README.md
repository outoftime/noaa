= noaa

* http://github.com/outoftime/noaa

== Description:

noaa is a library that provides an API for the National Oceanic and Atmospheric Association's weather
data feeds. It currently provides access to two types of data: current conditions (through NOAA::CurrentConditions) and
daily forecasts (through NOAA::Forecast).

== Features:

- Find both current conditions and daily forecasts using lat/lng.
- Access all relevant data returned by the NOAA using a simple and intuitive API

== Requirements:

- libxml-ruby >= 0.9.7 (if there is demand, I could look into allowing REXML as a fallback - shoot me an email)
- geokit >= 1.5.0

== Installation:

  sudo gem sources --add http://gems.github.com (only if you haven't done this before)
  sudo gem install outoftime-noaa
  sudo noaa-update-stations

== Usage:

  # Get current conditions
  conditions = NOAA.current_conditions(lat, lng)
  puts "The temperature is currently #{conditions.temperature} degrees, with #{conditions.weather_description.downcase} conditions."
  
  # Get closest weather station, then get current conditions
  # See discussion in documentation of NOAA.current_conditions
  # for why this is a good idea
  station_id = NOAA::Station.closest_to(lat, lng).id
  # persist the station id wherever...
  conditions = NOAA.current_conditions_for_station(station_id)

  # Get four-day forecast
  forecast = NOAA.forecast(4, lat, lng) # This method should not be called more than once an hour for a given lat/lng
  ['today', 'tomorrow', (Date.today + 2).to_s, (Date.today + 3).to_s].each_with_index do |date, i|
    puts "The high for #{date} will be #{forecast[i].high}"
  end

See the API documentation for further discussion.

== Contact:

Mat Brown (mat@patch.com)

I'm always open to feature requests, bugs, and patches.

== License:

(The MIT License)

Copyright (c) 2008 Mat Brown

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
