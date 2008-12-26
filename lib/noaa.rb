require 'rubygems'
gem 'libxml-ruby', '>= 0.9.7'
gem 'andre-geokit', '>= 1.2.0'

require 'time'
require 'libxml'
require 'geokit'

%w(current_conditions forecast forecast_day http_service station station_writer).each { |file| require File.join(File.dirname(__FILE__), 'noaa', file) }

module NOAA
  VERSION = '0.1.0'
end
