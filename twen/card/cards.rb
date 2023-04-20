# frozen_string_literal: true

require_relative '../module/camel_snake_resolver'
# @param none
class Cards
  extend CamelSnakeResolver
  def self.constant(constant_symbol)
    require_relative "../card/#{snakeization constant_symbol}"
    case constant_symbol
    when :CardN13S4J0
      CardN13S4J0
    end
  end
end

# p Cards.constant :CardN13S4J0
