class Application
  def run
    context = AppContext.new valera: Valera.new,
                             actions_container: ConfigLoader.load('./actions')
    app_state = AppStates::InputAction.new(context)
    until app_state.app_context.valera.died?
      app_state.render
      app_state = app_state.next
    end
  end
end

class AppContainer
  extend Dry::Container::Mixin

  register 'actions_container' do
    ConfigLoader.load('./actions')
  end
end

# Set up your auto-injection mixin
Import = Dry::AutoInject(AppContainer)

class AppContext
  attr_reader :valera, :prev_data

  include Import[actions_container]

  def initialize(valera:, prev_data:)
    @valera = valera
    @prev_data = prev_data
  end

  def available_actions
    actions_container.available_actions_for(valera)
  end
end
