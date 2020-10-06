require_relative '../types'
require 'dry-struct'

class Action < Dry::Struct
  class Effect < Dry::Struct
    attribute :field, Types::Coercible::String
    attribute :value, Types::Coercible::Integer
    attribute :operator, Types::Coercible::String.enum('+', '-')

    def execute(valera)
      valera.send("#{field}=", next_value(valera.send(field)))
      valera
    end

    private

    def next_value(prev_value)
      prev_value.send(operator, value)
    end
  end
end
