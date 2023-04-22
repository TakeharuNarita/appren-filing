# frozen_string_literal: true

require_relative 'jacker'
# @param none
class Player < Jacker
  def initialize(card, name = 'あなた')
    super(card)
    @name = name
  end
end
