# frozen_string_literal: true

require_relative '../jacker/player'
require_relative '../jacker/dealer'
require_relative '../jacker/npc'
require_relative 'card'

require 'byebug'
# @param none
class Game
  attr_accessor :deck, :player, :dealer, :limit

  def initialize(limit = 21)
    @card = Card.new(limit)
    @deck = []
    @card.len.times { @deck << _1 }
    @deck.shuffle!
  end

  def opening
    @jkrs = [Player.new(@card), Dealer.new(@card)]
    npclen = how_many 'NPCの人数を入力してください。', 0..2
    npclen.times { @jkrs << Npc.new(@card, "NPC_#{_1 + 1}") }
    self
  end

  def need_card(jkr)
    print "#{jkr.name}の引いた"
    jkr.hit(@deck.pop)
    puts
    self
  end

  def first_hit
    @jkrs.each { |jkr| 2.times { need_card jkr } }
    self
  end

  def adds_ques
    @jkrs.each do |jkr|
      jkr.adds_que(self)
    end
    self
  end

  def closing
    @jkrs.each { _1.totals }
    dea = @jkrs.find { _1.role == :dealer }
    plas = @jkrs.reject { _1.role == :dealer }
    battles(dea, plas)
  end

  private

  def how_many(msg, rang)
    x = rang.min
    xn = rang.max
    loop do
      print "#{msg} (#{x}~#{xn})\n"
      scn = gets.chomp.to_i

      return scn if rang.cover?(scn)

      puts "(#{x}~#{xn})内で入力してください。"
    end
  end

  def battles(dea, plas)
    plas.each do |pla|
      str_no = plas.size > 1 ? 'は' : 'の'
      pla.hands.each do |hand|
        str = pla.hands.size > 1 ? "#{hand}は" : ''
        print "#{pla.name}#{str}#{str_no}"
        battle(dea.hands[0], hand)
      end
    end
  end

  def battle(dhand, phand)
    if dhand.calc_scora > phand.calc_scora
      puts '負けです。'
    elsif dhand.calc_scora < phand.calc_scora
      puts '勝ちです！'
    else
      puts '引き分けです。'
    end
  end
end
