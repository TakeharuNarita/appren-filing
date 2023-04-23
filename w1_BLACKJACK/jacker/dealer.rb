# frozen_string_literal: true

require_relative 'jacker'
# @param none
class Dealer < Jacker
  def initialize(game, bet, name = 'ディーラー')
    super(game, bet)
    @name = name
    @role = :dealer
  end

  def hit(unq, hand_index = 0)
    @hands[hand_index].hit(unq)
    kown = "カードは#{@card.suit(unq)}の#{@card.rank(unq)}です。"
    unkown = '2枚目のカードはわかりません。'
    print @hands[hand_index].unqs.size == 2 ? unkown : kown
  end

  def act_que
    act_branch(0)
  end

  private

  def ac_none(hand_index = 0)
    print "#{@name}の引いた"
    unq = hands[0].unqs[1]
    puts "2枚目のカードは#{@card.suit(unq)}の#{@card.rank(unq)}でした。"
    loop do
      break if @hands[hand_index].burst?

      scn = ynq("カードを引きますか？（Y/N）\n")
      @game.need_card(self) if scn
      break unless scn
    end
  end

  def ynq(*)
    puts total(0, true) if draw_logic
    draw_logic
  end

  def draw_logic
    @card.scoring(hands[0].unqs) <= @card.limit * 17 / 21
  end
end
