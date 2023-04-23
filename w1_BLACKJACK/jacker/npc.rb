# frozen_string_literal: true

require_relative 'jacker'
# @param none
class Npc < Jacker
  def initialize(game, bet, name = 'npc')
    super(game, bet)
    @name = name
    @role = :npc
  end

  def act_que
    act_branch(0)
  end

  def ynq(*)
    puts
    draw_logic
  end

  def draw_logic
    @card.scoring(hands[0].unqs) <= @card.limit * rand(14..19) / 21
  end
end
