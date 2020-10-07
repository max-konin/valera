class Menu
  class Item
    attr_reader :action, :title

    def initialize(action:, title:)
      @action = action
      @title = title
    end
  end
end
