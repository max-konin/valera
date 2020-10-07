require_relative './io_adapter'
require_relative './menu/item'

class Menu
  def initialize(app_context)
    @app_context = app_context
  end

  def items
    @items ||= app_context
               .available_actions
               .map { |action| Item.new(action: action, title: action.before_text) }
               .concat([
                         Item.new(action: :save, title: 'Save'),
                         Item.new(action: :load, title: 'Load')
                       ])
  end

  def render
    items.each_with_index do |item, index|
      IOAdapter.write "[#{index}] #{item.title}"
    end
  end
end
