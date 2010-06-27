# -*- ruby -*-

ENV['RUBYOPT'] = '-W1'

require 'ftools'
require 'rubygems'
gem 'echoe', '~>3.0'
require 'echoe'
require './lib/noaa.rb'

Echoe.new('noaa', NOAA::VERSION) do |p|
  p.name = 'noaa'
  p.author = 'Mat Brown'
  p.description = 'Ruby API for National Oceanic and Atmospheric Administration weather data'
  p.email = 'mat@patch.com'
  p.url = 'http://github.com/outoftime/noaa'
  p.install_message = "Be sure to update the weather station list:\n\n\tsudo noaa-update-stations\n\nThis can be run at any time to update the stations, but you must run it once to initially populate the station list."
  p.runtime_dependencies = [Gem::Dependency.new('libxml-ruby', '>= 0.9.7'),
                            Gem::Dependency.new('geokit', '>= 1.5.0')]
  p.development_dependencies = [Gem::Dependency.new('jeremymcanally-context', '>= 0.0.6'),
                                Gem::Dependency.new('jeremymcanally-matchy', '>= 0.0.1'),
                                Gem::Dependency.new('ruby-debug', '~> 0.10')]
end

desc 'Create gemspec and copy it into project root'
task :gemspec => :package do
  File.copy(File.join(File.dirname(__FILE__), 'pkg', "noaa-#{NOAA::VERSION}", 'noaa.gemspec'), File.join(File.dirname(__FILE__), 'noaa.gemspec'))
end

# vim: syntax=Ruby
