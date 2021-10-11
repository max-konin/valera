class ValeraSerializer
  def initialize(valera)
    @valera = valera
  end

  def serialize
    {
      'health' => @valera.health,
      'mana' => @valera.mana,
      'fun' => @valera.fun,
      'fatigue' => @valera.fatigue,
      'money' => @valera.money
    }
  end
end
