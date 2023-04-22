# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'card'
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

  def battles(dea, plas)
    plas.each do |pla|
      pla.hands.each do |hand|
        str = pla.hands.size > 1 ? "#{hand}の" : ''
        print "#{pla.name}の#{str}"
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
