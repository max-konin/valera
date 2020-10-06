class ActionsContainer
  attr_accessor :actions

  def initialize(actions)
    @actions = actions
  end

  def available_actions_for(valera)
    actions.select { |action| action.valid?(valera) }
  end
end
