module NOAA
  class StationWriter
    def initialize(doc)
      @doc = doc
    end

    def write(io)
      YAML.dump(@doc.find('/wx_station_index/station').map { |node| node_to_hash(node) }, io)
    end

    private

    def node_to_hash(node)
      { 'latitude' => node_value(node, 'latitude').to_f,
        'longitude' => node_value(node, 'longitude').to_f,
        'id' => node_value(node, 'station_id'),
        'name' => node_value(node, 'station_name'),
        'state' => node_value(node, 'state'),
        'xml_url' => node_value(node, 'xml_url') }
    end

    def node_value(node, element)
      node.find("./#{element}/text()").first.to_s
    end
  end
end
