# frozen_string_literal: true

# @param none
class Hand
  attr_accessor :unqs, :card, :trash, :bet, :name

  def initialize(card, name = 1)
    @name = name
    @unqs = []
    @card = card
  end

  def hit(unq)
    @unqs << unq
  end

  def score
    @card.scoring(@unqs)
  end

  def burst?
    @card.burst?(@unqs)
  end
end
