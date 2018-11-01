class Valera
  attr_accessor :health, :fun, :money, :fatigue
  attr_reader :mana

  def initialize(health: 100, mana: 0, fun: 0, money: 0, fatigue: 0)
    self.health = health
    self.mana = mana
    self.fun = fun
    self.money = money
    self.fatigue = fatigue
  end

  def dead?
    health <= 0 || fun <= -10
  end

  def mana=(val)
    if val > 100
      @mana = 100
      self.health = health - (val - 100)
    else
      @mana = val
    end
  end
end
