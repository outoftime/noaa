require 'rubygems'
gem 'jeremymcanally-context', '>= 0.0.6'
gem 'jeremymcanally-matchy', '>= 0.0.1'
gem 'ruby-debug'


require 'context'
require 'matchy'
require 'ruby-debug'

require File.join(File.dirname(__FILE__), '..', 'lib', 'noaa')

module NOAA
  class TestCase < ::Test::Unit::TestCase
  end
end
