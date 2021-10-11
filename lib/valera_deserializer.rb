require_relative 'valera'

class ValeraDeserializer
  def initialize(hash)
    @hash = hash
  end

  def deserialize
    Valera.new @hash.transform_keys(&:to_sym)
  end
end
