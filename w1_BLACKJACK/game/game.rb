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

  def initialize(cache, limit = 21)
    @card = Card.new(limit)
    @cache = cache
    @deck = []
    @card.len.times { @deck << _1 }
    @deck.shuffle!
  end

  def bet(val = 0)
    @bet = val.zero? ? how_many('賭け金を入力してください。', 1..@cache[0]) : val
    puts "$ #{@bet}キャッシュを使用しました。残額: $ #{@cache[0] - @bet}"
    @cache[0] -= @bet
    self
  end

  def profit(val)
    @cache[0] += val
    puts "$ #{val}キャッシュの返金を受けました。残額: $ #{@cache[0]}"
    self
  end

  def opening
    @jkrs = [Player.new(self, @bet), Dealer.new(self, 0)]
    npclen = how_many 'NPCの人数を入力してください。', 0..2
    npclen.times { @jkrs << Npc.new(self, 0, "NPC_#{_1 + 1}") }
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

  def score_print
    @jkrs.each { _1.totals }
    dea = @jkrs.find { _1.role == :dealer }
    plas = @jkrs.reject { _1.role == :dealer }
    battles(dea, plas)
    self
  end

  def closing
    fit = 0
    @jkrs.find { _1.role == :player }.hands.each { fit = _1.bet }
    profit(fit) if fit != 0
  end

  def need_card(jkr, hand_index = 0)
    print "#{jkr.name}の引いた"
    jkr.hit(@deck.pop, hand_index)
    puts
    self
  end

  private

  def battles(dea, plas)
    plas.each do |pla|
      str_no = plas.size > 1 ? 'は' : 'の'
      pla.hands.each do |hand|
        str = pla.hands.size > 1 ? "手札#{hand.name}は" : ''
        print "#{pla.name}#{str_no}#{str}" unless hand.loser
        battle(dea.hands[0], hand) unless hand.loser
      end
    end
  end

  def battle(dhand, phand)
    if phand.burst? || dhand.score > phand.score && !dhand.burst?
      phand.bet -= phand.bet
      puts '負けです。'
    elsif dhand.score < phand.score || !phand.burst? && dhand.burst?
      phand.bet += phand.bet
      puts '勝ちです！'
    else
      puts '引き分けです。'
    end
  end
end
