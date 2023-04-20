# frozen_string_literal: true

require_relative 'jacker'
# @param none
class JackerPerson < Jacker
  def want?
    @connection.now_score score, self, nil
    @connection.pull_que
  end
end
