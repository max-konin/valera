class AppContext
  attr_reader :valera, :actions_container, :prev_data

  def initialize(valera:, actions_container:, prev_data:)
    @valera = valera
    @actions_container = actions_container
    @prev_data = prev_data
  end

  def available_actions
    actions_container.available_actions_for(valera)
  end
end
