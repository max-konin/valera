require_relative 'app_states/exit'
require_relative 'app_states/welcome'
require_relative 'app_context'
require_relative 'config_loader'

class Application
  def run
    context = AppContext.new valera: Valera.new,
                             actions_container: ConfigLoader.load(File.expand_path('../actions.yml', __dir__))
    app_state = AppStates::Welcome.new(context)
    until app_state.is_a? AppStates::Exit
      app_state.render
      app_state = app_state.next
    end
    app_state.render
  end
end
