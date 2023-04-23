# frozen_string_literal: true

require_relative 'console'

require_relative '../jacker/player'
require_relative '../jacker/dealer'
require_relative '../jacker/npc'
require_relative 'card'

# @param none
class Game
  include Console
  attr_accessor :deck, :player, :dealer, :limit, :card

  def initialize(limit = 21)
    @card = Card.new(limit)
    @deck = []
    @card.len.times { @deck << _1 }
    @deck.shuffle!
  end

  def opening
    @jkrs = [Player.new(self), Dealer.new(self)]
    npclen = how_many 'NPCの人数を入力してください。', 0..2
    npclen.times { @jkrs << Npc.new(self, "NPC_#{_1 + 1}") }
    self
  end

  def need_card(jkr, hand_index = 0)
    print "#{jkr.name}の引いた"
    jkr.hit(@deck.pop, hand_index)
    puts
    self
  end

  def first_hit
    @jkrs.each { |jkr| 2.times { need_card jkr } }
    self
  end

  def jkrs_ques
    @jkrs.each(&:act_que)
    self
  end

  def closing
    @jkrs.each { _1.totals }
    dea = @jkrs.find { _1.role == :dealer }
    plas = @jkrs.reject { _1.role == :dealer }
    battles(dea, plas)
  end

  private

  def battles(dea, plas)
    plas.each do |pla|
      str_no = plas.size > 1 ? 'は' : 'の'
      pla.hands.each do |hand|
        str = pla.hands.size > 1 ? "手札#{hand.name}は" : ''
        print "#{pla.name}#{str_no}#{str}"
        battle(dea.hands[0], hand)
      end
    end
  end

  def battle(dhand, phand)
    if phand.burst? || dhand.score > phand.score && !dhand.burst?
      puts '負けです。'
    elsif dhand.score < phand.score || !phand.burst? && dhand.burst?
      puts '勝ちです！'
    else
      puts '引き分けです。'
    end
  end
end
