# frozen_string_literal: true

require_relative '../user_interface/words'
require_relative '../game/one21'
require_relative '../module/camel_snake_resolver'
require_relative '../game/mountain'
# @param none
class One21
  include CamelSnakeResolver

  def initialize(consoles)
    @consoles = consoles
    @jackers = []
    @mountain = Mountain.new(:CardN13S4J0, 1)
  end

  def opening
    @mountain.shuffle
    jackers_new(:PersonPlayer)
    jackers_new(:NpcDealer)
    # 人数を入力してください。
    how_many_npc.times { jackers_new(:NpcPlayer) }
    # 賭け金を入力してください。
    @jackers.each { |j| 2.times { j.hands.each { _1.add @mountain.pull } } }
    self
  end

  def rep
    @consoles.each_with_index do |c, c_i|
      @jackers.each_with_index do |j, j_i|
        if j_i == c_i
          j_str = c.jacker_str :you
        else
          j_str = c.jacker_str (snake j.class).to_sym, { num: j.location_num }
        end
        j.hands.each {|hand| c.console_msg :draw, { name: j_str, suit: hand.index(1), num: hand.index(0)} }
      end
      # c.console_msg :your_hand, { hand: @jackers[i].hands.map(&:rep).join(' ') }
    end
  end

  private

  def how_many_npc
    npcs_len = 0
    loop do
      npcs_len = @consoles[0].open_question(:how_many_npc).to_i
      break if npcs_len.between?(0, 3) # 範囲内(min, max を含みます)に~

      @consoles[0].console_msg :invalid_input
    end
    npcs_len
  end

  def jackers_new(symbol)
    @jackers << constants('./jacker/', symbol).new(@consoles[0], self)
    @jackers.last.location_num = @jackers.length
  end

  def constants(dir, symbol)
    name = snake symbol
    require_relative "#{dir}/#{name}_con"
    require_relative "#{dir}/#{name}"
    ret_constants
  end
end
