# frozen_string_literal: true

require_relative 'jacker'
# @param none
class Dealer < Jacker
  def initialize(card, name = 'ディーラー')
    super(card)
    @name = name
    @role = :dealer
  end

  def hit(unq, hand_index = 0)
    @hands[hand_index].hit(unq)
    kown = "カードは#{@card.suit(unq)}の#{@card.rank(unq)}です。"
    unkown = '2枚目のカードはわかりません。'
    print @hands[hand_index].unqs.size == 2 ? unkown : kown
  end

  def adds_que(game)
    print "#{@name}の引いた"
    unq = hands[0].unqs[1]
    puts "2枚目のカードは#{@card.suit(unq)}の#{@card.rank(unq)}でした。"
    super game
  end

  def draw_ynq(*)
    puts
    @card.scoring(hands[0].unqs) <= 17
  end
end
