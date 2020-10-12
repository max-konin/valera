require_relative 'base'
require_relative '../io_adapter'

module AppStates
  class Exit < Base
    def render
      IOAdapter.instance.write 'Goodbye!'
    end

    def next
      raise 'Exit state does not have the next state'
    end
  end
end
