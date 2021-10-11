require 'yaml'
require_relative './valera_deserializer'
require 'pathname'

class GameLoader
  def initialize(filename)
    @filename = File.expand_path("../_saves/#{filename}.yaml", __dir__)
  end

  def valid?
    Pathname.new(@filename).exist?
  end

  def load
    data = YAML.safe_load(File.open(@filename))
    ValeraDeserializer.new(data).deserialize
  end
end
