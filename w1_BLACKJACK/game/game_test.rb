# frozen_string_literal: true

require_relative 'game'
# @param none
class GameTest < Game
  attr_accessor :deck, :player, :dealer, :limit, :card, :jkrs
end

game = GameTest.new
pp game.opening.first_hit.adds_ques

