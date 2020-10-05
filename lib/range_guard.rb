require_relative 'types'
require 'dry-struct'

class RangeGuard < Dry::Struct
  attribute :min, Types::Coercible::Integer
  attribute :max, Types::Coercible::Integer

  def cut(value)
    cut_value = [[value, min].max, max].min
    Result.new value: cut_value, rest: value - cut_value
  end

  class Result < Dry::Struct
    attribute :value, Types::Coercible::Integer
    attribute :rest, Types::Coercible::Integer
  end
end
