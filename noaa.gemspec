# -*- encoding: utf-8 -*-
# stub: noaa 0.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "noaa"
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mat Brown"]
  s.date = "2014-12-09"
  s.description = "Ruby API for National Oceanic and Atmospheric Administration weather data"
  s.email = "mat@patch.com"
  s.executables = ["noaa-update-stations"]
  s.extra_rdoc_files = ["CHANGELOG", "README", "bin/noaa-update-stations", "lib/noaa.rb", "lib/noaa/current_conditions.rb", "lib/noaa/forecast.rb", "lib/noaa/forecast_day.rb", "lib/noaa/http_service.rb", "lib/noaa/station.rb", "lib/noaa/station_writer.rb", "lib/noaa/version.rb"]
  s.files = ["CHANGELOG", "Manifest", "README", "Rakefile", "bin/noaa-update-stations", "data/stations.yml", "lib/noaa.rb", "lib/noaa/current_conditions.rb", "lib/noaa/forecast.rb", "lib/noaa/forecast_day.rb", "lib/noaa/http_service.rb", "lib/noaa/station.rb", "lib/noaa/station_writer.rb", "lib/noaa/version.rb", "noaa.gemspec", "test/data/4-day.xml", "test/data/KVAY.xml", "test/data/stations-abridged.xml", "test/data/stations.xml", "test/data/stations.yml", "test/test_current_conditions.rb", "test/test_forecast.rb", "test/test_helper.rb", "test/test_http_service.rb", "test/test_station.rb", "test/test_station_writer.rb"]
  s.homepage = "http://github.com/outoftime/noaa"
  s.post_install_message = "Be sure to update the weather station list:\n\n\tsudo noaa-update-stations\n\nThis can be run at any time to update the stations, but you must run it once to initially populate the station list."
  s.rdoc_options = ["--line-numbers", "--title", "Noaa", "--main", "README"]
  s.rubyforge_project = "noaa"
  s.rubygems_version = "2.4.5"
  s.summary = "Ruby API for National Oceanic and Atmospheric Administration weather data"
  s.test_files = ["test/test_helper.rb", "test/test_station_writer.rb", "test/test_http_service.rb", "test/test_current_conditions.rb", "test/test_forecast.rb", "test/test_station.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<libxml-ruby (>= 0.9.7)>, [">= 0"])
      s.add_runtime_dependency(%q<geokit (>= 1.5.0)>, [">= 0"])
      s.add_development_dependency(%q<jeremymcanally-context (>= 0.0.6)>, [">= 0"])
      s.add_development_dependency(%q<jeremymcanally-matchy (>= 0.0.1)>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug (~> 0.10)>, [">= 0"])
    else
      s.add_dependency(%q<libxml-ruby (>= 0.9.7)>, [">= 0"])
      s.add_dependency(%q<geokit (>= 1.5.0)>, [">= 0"])
      s.add_dependency(%q<jeremymcanally-context (>= 0.0.6)>, [">= 0"])
      s.add_dependency(%q<jeremymcanally-matchy (>= 0.0.1)>, [">= 0"])
      s.add_dependency(%q<ruby-debug (~> 0.10)>, [">= 0"])
    end
  else
    s.add_dependency(%q<libxml-ruby (>= 0.9.7)>, [">= 0"])
    s.add_dependency(%q<geokit (>= 1.5.0)>, [">= 0"])
    s.add_dependency(%q<jeremymcanally-context (>= 0.0.6)>, [">= 0"])
    s.add_dependency(%q<jeremymcanally-matchy (>= 0.0.1)>, [">= 0"])
    s.add_dependency(%q<ruby-debug (~> 0.10)>, [">= 0"])
  end
end
