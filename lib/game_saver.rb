require 'yaml'
require_relative './valera_serializer'

class GameSaver
  def initialize(filename, valera)
    @filename = File.expand_path("../_saves/#{filename}.yaml", __dir__)
    @valera = valera
  end

  def save
    yaml = ValeraSerializer.new(@valera).serialize.to_yaml
    File.open(@filename, 'w') { |file| file.write(yaml) }
  end
end
