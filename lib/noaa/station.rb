module NOAA
  class Station
    class <<self
      attr_writer :stations_file

      def find(id)
        stations.find { |station| station.id == id }
      end

      def closest_to(*args)
        if args.length == 1
          if args.first.respond_to?(:distance_to)
            closest_to_coordinates(args.first)
          elsif %w(first last).all? { |m| args.first.respond_to?(m) }
            closest_to_lat_lng(args.first)
          else
            raise ArgumentError, "expected two-element Array or GeoKit::LatLng"
          end
        elsif args.length == 2
          closest_to_lat_lng(args)
        else
          raise ArgumentError, "closest_to() will accept one Array argument, one GeoKit::LatLng argument, or two FixNum arguments"
        end
      end

      private

      def closest_to_lat_lng(pair)
        closest_to_coordinates(GeoKit::LatLng.new(pair.first, pair.last))
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
          YAML.load(file).map { |station_hash| new(station_hash) }
        end
      end

      def stations_file
        @stations_file ||= File.join(File.dirname(__FILE__), '..', '..', 'data', 'stations.yml')
      end
    end

    attr_reader :coordinates, :id, :name, :state, :xml_url

    def initialize(properties)
      @id, @name, @state, @xml_url = %w(id name state xml_url).map do |p|
        properties[p]
      end
      @coordinates = GeoKit::LatLng.new(properties['latitude'], properties['longitude'])
    end
    
    def latitude
      @coordinates.lat
    end
    alias_method :lat, :latitude

    def longitude
      @coordinates.lng
    end
    alias_method :lng, :longitude
  end
end
