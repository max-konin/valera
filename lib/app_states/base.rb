require_relative '../io_adapter'

module AppStates
  class Base
    attr_reader :app_context

    def initialize(app_context)
      @app_context = app_context
    end

    def render; end

    def next; end

    def io_adapter
      IOAdapter.instance
    end
  end
end
