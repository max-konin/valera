require_relative 'base'
require_relative '../io_adapter'

module AppStates
  class ValeraDead < Base
    def render
      io_adapter.write 'Valera has dead, :('
      main_menu.render
    end

    def next
      sleep 1000
      self
    end

    private

    def io_adapter
      IOAdapter.instance
    end

    def main_menu
      @main_menu ||= MainMenuFactory.build
    end
  end
end
