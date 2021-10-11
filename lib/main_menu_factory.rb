require_relative './components/menu'

class MainMenuFactory
  MENU_ITEMS = [
    { title: 'Save', command: 'save', action: :save },
    { title: 'Load', command: 'load', action: :load },
    { title: 'Exit', command: 'exit', action: :exit }
  ].freeze

  def initialize(only:)
    @only = only || MENU_ITEMS.map { |item| item[:action] }
  end

  def build
    Components::Menu.new(
      layout: 'horizontal',
      items: MENU_ITEMS.select { |item| @only.include?(item[:action]) }
    )
  end

  def self.build(only: %i[save load exit])
    new(only: only).build
  end
end
