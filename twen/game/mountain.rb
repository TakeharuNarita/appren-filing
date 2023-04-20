# frozen_string_literal: true

require_relative '../module/camel_snake_resolver'
require_relative '../card/cards'
# @param none
class Mountain
  include CamelSnakeResolver

  def initialize(card, val)
    @deck = []
    val.times { (0...(card.len)).each { @deck.push _1 } }
  end

  def shuffle
    @deck.shuffle!
  end

  def pull
    @deck.delete_at 0
  end
end

# m = Mountain.new([:CardN13S4J0, 1])
# p m.shuffle
# p m.pull
# p m
