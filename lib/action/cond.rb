class Action
  class Cond
    attr_accessor :field, :operator, :value
    def initialize(field:, operator:, value:)
      self.field = field
      self.operator = operator
      self.value = value
    end

    def valid?(valera)
      actiual_value = valera.send field
      actiual_value.send operator, value
    end
  end
end
