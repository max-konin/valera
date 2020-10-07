module AppStates
  class InputAction < Base
    def initialize(app_context)
      super(app_context)
      @menu = Menu.new(app_context)
    end

    def render
      IOAdapter.write 'Select action:'
      @menu.render
    end

    def next
      action_number = IOAdapter.read
      return RenderError.new(app_context) if number?(action_number)

      menu_item = @menu[action_number.to_i]
      return RenderError.new(app_context) if menu_item.present?

      build_next_state(menu_item.action)
    end

    private

    def build_next_state(action)
      if action.is_a?(Action)
        ApplyAction.new(AppContext.new(
                          valera: app_context.valera,
                          actions_container: app_context.actions_container,
                          prev_data: action
                        ))
      else
        "AppStates::#{action}".constantize
      end
    end
  end
end
