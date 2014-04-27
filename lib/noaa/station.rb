module NOAA
  # 
  # Data about an NOAA observation station. When accessing current conditions, the NOAA XML API
  # takes a station ID as input; thus, to find the current conditions for an arbitrary location, one
  # must first determine the closest weather station to that location. The NOAA.current_conditions
  # method performs this task implicitly; however, for applications that need to find conditions
  # for the same location(s) repeatedly, it is far more efficient to find the closest weather station
  # once, store that information, and then query directly against the weather station when updated
  # conditions are needed.
  #
  # Station data is stored in a YAML file that is created using the <tt>noaa-update-stations</tt> executable.
  # Be sure to run this command at least once when you first install the NOAA library, and any time
  # thereafter that you would like to get the latest list of stations. I don't imagine the list
  # changes very often but I don't really have any idea.
  #
  class Station
    class <<self
      attr_writer :stations_file #:nodoc:

      #
      # Retrieve information about a station given a station ID
      #
      #   NOAA::Station.find('KNYC')  #=> NOAA::Station object for the Central Park station
      def find(id)
        stations.find { |station| station.id == id }
      end

      # 
      # Find the station closest to a given location. Can accept arguments in any of the following
      # three forms (all are equivalent):
      #
      #   NOAA::Station.closest_to(37.989, -77.507)
      #   NOAA::Station.closest_to([37.989, -77.507])
      #   NOAA::Station.closest_to(Geokit::LatLng.new(37.989, -77.507))
      def closest_to(*args)
        if args.length == 1
          if args.first.respond_to?(:distance_to)
            closest_to_coordinates(args.first)
          elsif %w(first last).all? { |m| args.first.respond_to?(m) }
            closest_to_lat_lng(args.first)
          else
            raise ArgumentError, "expected two-element Array or Geokit::LatLng"
          end
        elsif args.length == 2
          closest_to_lat_lng(args)
        else
          raise ArgumentError, "closest_to() will accept one Array argument, one Geokit::LatLng argument, or two FixNum arguments"
        end
      end

      private

      def closest_to_lat_lng(pair)
        closest_to_coordinates(Geokit::LatLng.new(pair.first, pair.last))
      end

      def closest_to_coordinates(coordinates)
        stations.map do |station|
          [coordinates.distance_to(station.coordinates), station]
        end.min do |p1, p2|
          p1.first <=> p2.first # compare distance
        end[1]
      end

      def stations
        File.open(stations_file) do |file|
          yaml = YAML.load(file) || raise("Can't parse #{file.path} - be sure to run noaa-update-stations")
          yaml.map { |station_hash| new(station_hash) }
        end
      end

      def stations_file
        @stations_file ||= File.join(File.dirname(__FILE__), '..', '..', 'data', 'stations.yml')
      end
    end

    # Geokit::LatLng containing the station's coordinates
    attr_reader :coordinates

    # Station ID (e.g., "KNYC")
    attr_reader :id

    # Station name (e.g., "New York City, Central Park")
    attr_reader :name
    
    # Two-digit abbreviation for state in which station resides (e.g., "NY")
    attr_reader :state
    
    attr_reader :xml_url #:nodoc:

    def initialize(properties)
      @id, @name, @state, @xml_url = %w(id name state xml_url).map do |p|
        properties[p]
      end
      @coordinates = Geokit::LatLng.new(properties['latitude'], properties['longitude'])
    end
    
    # Latitude of station
    def latitude
      @coordinates.lat
    end
    alias_method :lat, :latitude

    # Longitude of station
    def longitude
      @coordinates.lng
    end
    alias_method :lng, :longitude
    alias_method :lon, :longitude
  end
end
