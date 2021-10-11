require_relative 'base'
require_relative '../io_adapter'
require_relative 'valera_dead'
require_relative 'save'
require_relative 'load'
require_relative 'exit'

module AppStates
  class Play < Base
    def render
      io_adapter.write 'Valera wanna:'
      menu.render
      io_adapter.write '---'
      main_menu.render
    end

    def next
      input = io_adapter.read
      action = main_menu.handle_input(input) || menu.handle_input(input) || :error
      if private_methods.include?(:"action_#{action}")
        send "action_#{action}"
      else
        handle_valera_action action
      end
    end

    private

    def handle_valera_action(index)
      action = @app_context.available_actions[index]
      action.execute(@app_context.valera)
      io_adapter.write(action.after_text)
      next_state_after_action
    end

    def next_state_after_action
      klass = @app_context.valera.dead? ? ValeraDead : Play
      klass.new @app_context
    end

    def action_error
      io_adapter.write 'Incorrect input'
      self
    end

    def action_exit
      Exit.new app_context
    end

    def action_load
      Load.new app_context
    end

    def action_save
      Save.new app_context
    end

    def menu
      @menu ||= Components::Menu.new(
        layout: 'vertical',
        items: @app_context
          .available_actions
          .each_with_index
          .map { |action, index| build_meny_item_per_action(action, index) }
      )
    end

    def build_meny_item_per_action(action, index)
      {
        action: index,
        command: index.to_s.to_sym,
        title: action.before_text
      }
    end

    def main_menu
      @main_menu ||= MainMenuFactory.build
    end

    def io_adapter
      IOAdapter.instance
    end
  end
end
