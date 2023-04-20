# frozen_string_literal: true

require_relative '../module/camel_snake_resolver'
# @param none
class Mountain
  include CamelSnakeResolver

  def initialize(deck, val)
    require_relative "../card/#{snakeization deck}"
    card = (eval deck.to_s).new # rubocop:disable Security/Eval
    @cards = []
    val.times { (0...(card.len)).each { @cards.push _1 } }
  end

  def shuffle
    @cards.shuffle
  end

  # def cards
  #   @cards
  # end
end

p Mountain.new(:CardN13S4J0, 2).shuffle
