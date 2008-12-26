# -*- ruby -*-

ENV['RUBYOPT'] = '-W1'

require 'rubygems'
require 'hoe'
require './lib/noaa.rb'

Hoe.new('noaa', NOAA::VERSION) do |p|
  p.name = 'noaa'
  p.author = 'Mat Brown'
  p.description = 'Ruby API for National Oceanic and Atmospheric Administration weather data'
  p.email = 'mat@patch.com'
  p.url = 'http://github.com/outoftime/noaa'
  p.extra_deps = [Gem::Dependency.new('libxml-ruby', '>= 0.9.7'),
                  Gem::Dependency.new('andre-geokit', '>= 1.2.0')]
  p.extra_dev_deps = [Gem::Dependency.new('jeremymcanally-context', '>= 0.0.6'),
                      Gem::Dependency.new('jeremymcanally-matchy', '>= 0.0.1'),
                      Gem::Dependency.new('ruby-debug', '~> 0.10')]
  p.developer('Mat Brown', 'mat@patch.com')
end

# vim: syntax=Ruby
