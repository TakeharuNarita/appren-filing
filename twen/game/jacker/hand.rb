# frozen_string_literal: true

require_relative 'handling_card'
# @param none
class Hand
  attr_accessor :card

  def initialize
    @cards = []
    @limit = 21
  end

  def push(val)
    @cards << HandingCard.new(val)
  end

  def add(val)
    @cards << HandingCard.new(val)
  end

  def map
    @cards
  end

  def burst?
    score > @limit
  end

  def score
    scoring @cards.map(&:card_unq), @card
  end

  def want?
  end

  private

  def scoring(unqs, card)
    nums = unqs.map { |unq| card.num(unq) > 10 ? 10 : card.num(unq) }
    patterns = [nums.sum]
    patterns << nums.sum + 10 if nums.include?(1)
    patterns.select { |pattern| pattern <= @upper_limit }.max || patterns.min
  end
end
