# frozen_string_literal: true

require_relative 'handling_card'
# @param none
class Hand
  def initialize
    @cards = []
  end

  def push(val)
    @cards << HandingCard.new(val)
  end

  def add(val)
    @cards << HandingCard.new(val)
  end

  def cards(ind)
    @cards
  end

  def index(ind)
    @cards[ind]
  end

  def map
    @cards
  end
end
