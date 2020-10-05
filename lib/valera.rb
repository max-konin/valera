require_relative 'range_guard'

class Valera
  attr_accessor :money
  attr_reader :health, :fun, :mana, :fatigue

  def initialize(health: 100, mana: 0, fun: 0, money: 0, fatigue: 0)
    init_scales_guards

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
    cut_result = @hundred_point_scale_guard.cut(val)
    @mana = cut_result.value
    self.health = health - cut_result.rest if cut_result.rest.positive?
  end

  def health=(val)
    @health = @hundred_point_scale_guard.cut(val).value
  end

  def fatigue=(val)
    @fatigue = @hundred_point_scale_guard.cut(val).value
  end

  def fun=(val)
    @fun = @fun_scale_guard.cut(val).value
  end

  private

  def init_scales_guards
    @hundred_point_scale_guard = RangeGuard.new min: 0, max: 100
    @fun_scale_guard = RangeGuard.new min: -10, max: 10
  end
end
