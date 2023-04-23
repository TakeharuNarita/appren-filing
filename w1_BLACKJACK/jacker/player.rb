# frozen_string_literal: true

require_relative 'jacker'
# @param none
class Player < Jacker
  def initialize(game, name: 'あなた')
    super(game)
    @name = name
  end
end
