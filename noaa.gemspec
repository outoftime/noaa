# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{noaa}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mat Brown"]
  s.date = %q{2009-01-04}
  s.default_executable = %q{noaa-update-stations}
  s.description = %q{Ruby API for National Oceanic and Atmospheric Administration weather data}
  s.email = %q{mat@patch.com}
  s.executables = ["noaa-update-stations"]
  s.extra_rdoc_files = ["lib/noaa/forecast.rb", "lib/noaa/http_service.rb", "lib/noaa/current_conditions.rb", "lib/noaa/station_writer.rb", "lib/noaa/station.rb", "lib/noaa/forecast_day.rb", "lib/noaa.rb", "bin/noaa-update-stations", "CHANGELOG", "README"]
  s.files = ["lib/noaa/forecast.rb", "lib/noaa/http_service.rb", "lib/noaa/current_conditions.rb", "lib/noaa/station_writer.rb", "lib/noaa/station.rb", "lib/noaa/forecast_day.rb", "lib/noaa.rb", "Rakefile", "Manifest", "data/stations.yml", "bin/noaa-update-stations", "CHANGELOG", "test/test_station_writer.rb", "test/test_forecast.rb", "test/data/stations.xml", "test/data/stations-abridged.xml", "test/data/stations.yml", "test/data/KVAY.xml", "test/data/4-day.xml", "test/test_helper.rb", "test/test_station.rb", "test/test_http_service.rb", "test/test_current_conditions.rb", "README", "noaa.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/outoftime/noaa}
  s.post_install_message = %q{Be sure to update the weather station list:

	sudo noaa-update-stations

This can be run at any time to update the stations, but you must run it once to initially populate the station list.}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Noaa", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{noaa}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby API for National Oceanic and Atmospheric Administration weather data}
  s.test_files = ["test/test_station_writer.rb", "test/test_forecast.rb", "test/test_helper.rb", "test/test_station.rb", "test/test_http_service.rb", "test/test_current_conditions.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 0.9.7"])
      s.add_runtime_dependency(%q<geokit>, [">= 1.5.0"])
      s.add_development_dependency(%q<jeremymcanally-context>, [">= 0.0.6"])
      s.add_development_dependency(%q<jeremymcanally-matchy>, [">= 0.0.1"])
      s.add_development_dependency(%q<ruby-debug>, ["~> 0.10"])
    else
      s.add_dependency(%q<libxml-ruby>, [">= 0.9.7"])
      s.add_dependency(%q<geokit>, [">= 1.5.0"])
      s.add_dependency(%q<jeremymcanally-context>, [">= 0.0.6"])
      s.add_dependency(%q<jeremymcanally-matchy>, [">= 0.0.1"])
      s.add_dependency(%q<ruby-debug>, ["~> 0.10"])
    end
  else
    s.add_dependency(%q<libxml-ruby>, [">= 0.9.7"])
    s.add_dependency(%q<geokit>, [">= 1.5.0"])
    s.add_dependency(%q<jeremymcanally-context>, [">= 0.0.6"])
    s.add_dependency(%q<jeremymcanally-matchy>, [">= 0.0.1"])
    s.add_dependency(%q<ruby-debug>, ["~> 0.10"])
  end
end
