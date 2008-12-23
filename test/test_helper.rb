require 'rubygems'
gem 'jeremymcanally-context', '>= 0.0.6'
gem 'jeremymcanally-matchy', '>= 0.0.1'


require 'context'
require 'matchy'

require File.join(File.dirname(__FILE__), '..', 'lib', 'noaa')

module NOAA
  class TestCase < ::Test::Unit::TestCase
  end
end
