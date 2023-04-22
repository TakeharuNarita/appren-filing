# frozen_string_literal: true

require_relative 'jacker_npc'
# @param none
class NpcDealer < JackerNpc
  def draw(val)
    @hand.push val
    @connection.pull_msg val, self, @hand.map.length == 2 ? nil : val
  end

  def second_release
    @connection.release_msg @hand.index(1), self
  end

  def want?
    @connection.now_score score, self, score if score < 17
    score < 17 ? 1 : nil
  end

  def permissions(index)
    index == 0 ? 444 : 0
  end
end
