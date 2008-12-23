require 'rubygems'
gem 'libxml-ruby', '>= 0.9.7'

require 'time'
require 'libxml'

%w(current_conditions forecast forecast_day).each { |file| require File.join(File.dirname(__FILE__), 'noaa', file) }

module NOAA
  VERSION = '0.1.0'
end
