# frozen_string_literal: true

require_relative './game/game'
# @param none
class User
  def initialize
    @cache = [100]
  end

  def join
    puts 'ブラックジャックを開始します。'
    Game.new(@cache).bet.opening.first_hit.jkrs_ques.score_print.closing
    puts 'ブラックジャックを終了します。'
    p @cache
  end

  def lord_cache
    # @cache
  end

  def save_cache
    # @cache
  end
end
User.new.join
