# frozen_string_literal: true

require_relative '../user_interface/words'
require_relative '../module/camel_snake_resolver'
require_relative '../game/mountain'
# @param none
class Off21
  def initialize(consoles)
    @consoles = consoles
  end

  private

  def draw(hand, jkr)
    hand.add @mountain.pull
    hand.map.last.permission = jkr.permissions(hand.map.length - 1)
    hand.card = @mountain.card
  end

  def draw_know(jkr)
    @consoles.each_with_index do |c, c_i|
      who = jkr.location_num == c_i + 1 ? [:you] : [(snake jkr.class).to_sym, { num: jkr.location_num }]
      jkr.hands.each do |hand|
        hand.map.each_with_index do |handing, card_num|
          draw_card_know(handing, card_num, c, who)
        end
      end
    end
  end

  def draw_card_know(handing, card_num, console, who)
    j_str = console.jacker_str(*who)
    if who == [:you] || handing.permission % 10 == 4
      suit = console.card_str @mountain.card.suit(handing.card_unq)
      num = console.card_str @mountain.card.num(handing.card_unq)
      console.console_msg :draw, { name: j_str, suit: suit, num: num }
    else
      console.console_msg :dont_know, { name: j_str, index: card_num + 1 }
    end
  end

  def how_many_npc
    npcs_len = 0
    loop do
      npcs_len = @consoles[0].open_question(:how_many_npc).to_i
      break if npcs_len.between?(0, 2) # 範囲内(min, max を含みます)に~

      @consoles[0].console_msg :invalid_input
    end
    npcs_len
  end

  def how_many_bet
    @consoles.each_with_index do |c, c_i|
      bet = 0
      loop do
        bet = c.open_question(:how_many_bet, { cache: c.cache }).to_i
        break if bet.between?(0, c.cache) # 範囲内(min, max を含みます)に~

        c.console_msg :invalid_input
      end
      c.cache_bet = bet
      @jackers[c_i].bet = bet
    end
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
