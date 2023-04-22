# frozen_string_literal: true

# @param none
class Hand
  attr_accessor :unqs, :card, :burst, :calc_scora

  def initialize(card)
    @unqs = []
    @card = card
  end

  def hit(unq)
    @unqs << unq
  end

  def score
    @burst = @card.burst?(@unqs)
    @calc_scora = @burst ? 0 : @card.scoring(@unqs)
    @card.scoring(@unqs)
  end
end
