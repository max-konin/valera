require_relative '../types'
require 'dry-struct'

class Action < Dry::Struct
  class Cond < Dry::Struct
    transform_keys(&:to_sym)

    attribute :field, Types::Coercible::String
    attribute :value, Types::Coercible::Integer
    attribute :operator, Types::Coercible::String.enum('>', '<', '>=', '<=', '==')

    def valid?(valera)
      actiual_value = valera.send field
      actiual_value.send operator, value
    end
  end
end
