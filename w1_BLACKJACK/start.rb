# frozen_string_literal: true

require_relative './game/game'
# @param none

puts 'ブラックジャックを開始します。'
Game.new.opening.first_hit.adds_ques.closing
puts 'ブラックジャックを終了します。'
