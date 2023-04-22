# frozen_string_literal: true

require_relative 'jacker'
# @param none
class Npc < Jacker
  def initialize(card, name = 'NPC')
    super(card)
    @name = name
    @role = :npc
  end

  def draw_ynq(*)
    puts
    rnd = rand(@card.limit * 16 / 21..@card.limit - 1)
    @card.scoring(hands[0].unqs) <= rnd
  end
end
