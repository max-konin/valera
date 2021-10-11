require_relative 'base'
require_relative '../io_adapter'
require_relative '../game_saver'
require_relative 'play'

module AppStates
  class Save < Base
    def render
      io_adapter.write 'Filename:'
      io_adapter.write '---'
      main_menu.render
    end

    def next
      input = io_adapter.read
      main_menu_action = main_menu.handle_input(input)
      return send("action_#{main_menu_action}") if main_menu_action

      save_to_file(input)
    end

    private

    def save_to_file(input)
      saver = GameSaver.new input, app_context.valera
      saver.save
      io_adapter.write 'Saved'
      Play.new app_context
    end

    def action_exit
      Exit.new app_context
    end

    def main_menu
      @main_menu ||= MainMenuFactory.build only: [:exit]
    end
  end
end
