# frozen_string_literal: true

require_relative 'jacker'
# @param none
class Player < Jacker
  def initialize(game, bet, name: 'あなた')
    super(game, bet)
    @name = name
  end
end
