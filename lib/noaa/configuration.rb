require 'yaml'
module NOAA
  class Configuration
    attr_accessor :station

    def load_with_hash(hash)
      hash.each do |k, v|
        setter_command = "#{k}="
        send(setter_command, v) if respond_to? setter_command
      end
    end
  end
end
