require 'yaml'
require_relative './action'
require_relative './actions_container'

class ConfigLoader
  def initialize(file)
    @file = file
  end

  def load
    ActionsContainer.new(
      YAML.safe_load(File.open(@file)).map { |data| build_action(data) }
    )
  end

  def self.load(file)
    new(file).load
  end

  private

  def build_action(data)
    Action.new data
  end
end
