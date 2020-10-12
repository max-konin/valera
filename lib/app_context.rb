require_relative 'valera'
require_relative 'actions_container'
require 'dry-struct'
require_relative 'types'

class AppContext < Dry::Struct
  attribute :valera, Types.Instance(Valera)
  attribute :actions_container, Types.Instance(ActionsContainer)
  attribute :prev_data, Types::Hash.default({}.freeze)

  def available_actions
    actions_container.available_actions_for(valera)
  end
end
