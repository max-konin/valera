require_relative '../main_menu_factory'
require_relative '../components/menu'
require_relative '../io_adapter'
require_relative 'base'
require_relative 'play'
require_relative 'exit'
require_relative 'load'

module AppStates
  class Welcome < Base
    def render
      io_adapter.write 'Valera Game'
      menu.render
      io_adapter.write '---'
      main_menu.render
    end

    def next
      send "action_#{handle_user_input}"
    end

    private

    def action_error
      io_adapter.write 'Incorrect input'
      self
    end

    def action_play
      Play.new app_context
    end

    def action_exit
      Exit.new app_context
    end

    def action_load
      Load.new app_context
    end

    def handle_user_input
      input = io_adapter.read
      main_menu.handle_input(input) || menu.handle_input(input) || :error
    end

    def io_adapter
      IOAdapter.instance
    end

    def menu
      @menu ||= Components::Menu.new(
        layout: 'vertical',
        items: [
          { title: 'Start a new game', command: '1', action: :play },
          { title: 'Load', command: '2', action: :load }
        ]
      )
    end

    def main_menu
      @main_menu ||= MainMenuFactory.build only: [:exit]
    end
  end
end
