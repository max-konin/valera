require_relative 'base'
require_relative '../io_adapter'
require_relative '../game_loader'
require_relative '../app_context'
require_relative 'play'

module AppStates
  class Load < Base
    def render
      io_adapter.write 'Filename:'
      io_adapter.write '---'
      main_menu.render
    end

    def next
      input = io_adapter.read
      main_menu_action = main_menu.handle_input(input)
      return send("action_#{main_menu_action}") if main_menu_action

      load_from_file(input)
    end

    private

    def load_from_file(input)
      loader = GameLoader.new input
      if loader.valid?
        valera = loader.load
        new_context = AppContext.new valera: valera,
                                     actions_container: app_context.actions_container
        Play.new new_context
      else
        io_adapter.write 'Save not found'
        self
      end
    end

    def action_exit
      Exit.new app_context
    end

    def main_menu
      @main_menu ||= MainMenuFactory.build only: [:exit]
    end
  end
end
