require 'dry-struct'
require_relative '../types'
require_relative '../io_adapter'

module Components
  class Menu < Dry::Struct
    class Item < Dry::Struct
      attribute :title, Types::Coercible::String
      attribute :action, Types::Coercible::Symbol
      attribute :command, Types::Coercible::String

      def text_to_render
        "[#{command}] #{title}"
      end
    end

    Layouts = Types::String.enum('vertical', 'horizontal')

    attribute :items, Types::Strict::Array.of(Item)
    attribute :layout, Layouts

    def render
      send "render_#{layout}"
    end

    def handle_input(input)
      items.find { |item| item.command == input }
        &.action
    end

    private

    def render_vertical
      texts.each { |t| IOAdapter.instance.write(t) }
    end

    def render_horizontal
      IOAdapter.instance.write(
        texts.join(' | ')
      )
    end

    def texts
      items.map(&:text_to_render)
    end
  end
end
