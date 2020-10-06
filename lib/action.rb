require 'dry-struct'
require_relative 'types'
require_relative 'action/cond'
require_relative 'action/effect'

class Action < Dry::Struct
  attribute :before_text, Types::Coercible::String.default('')
  attribute :after_text, Types::Coercible::String.default('')
  attribute :conds, Types::Strict::Array.of(Action::Cond)
  attribute :effects, Types::Strict::Array.of(Action::Effect)

  def valid?(valera)
    conds.map { |c| c.valid?(valera) }
         .inject(true) { |acc, el| acc && el }
  end

  def execute(valera)
    effects.inject(valera) { |v, eff| eff.execute(v) }
  end
end
