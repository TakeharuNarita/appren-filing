# frozen_string_literal: true

require_relative 'jacker_npc'
# @param none
class NpcPlayer < JackerNpc
  def want?
    @connection.now_score score, self, score if score < 17
    score < 17 ? 1 : nil
  end
end
