# frozen_string_literal: true

# @param none
class Hand
  attr_accessor :unqs, :bet, :loser
  attr_reader :card, :name

  def initialize(card, bet = 0, name = 1)
    @bet = bet
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
