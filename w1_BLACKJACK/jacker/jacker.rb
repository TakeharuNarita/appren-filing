# frozen_string_literal: true

require_relative 'hand'
# @param none
class Jacker
  attr_accessor :hands, :name, :role

  def initialize(card)
    @card = card
    @hands = [Hand.new(card)]
    @role = :player
  end

  def hit(unq, hand_index = 0)
    @hands[hand_index].hit(unq)
    print "カードは#{@card.suit(unq)}の#{@card.rank(unq)}です。"
  end

  def adds_que(game)
    @hands.each do |hand|
      loop do
        break unless one_que(self, game, hand)
      end
    end
  end

  def totals
    @hands.each do |hand|
      str = @hands.size > 1 ? "#{hand}の" : ''
      puts "#{@name}の#{str}得点は#{hand.score}です。"
    end
  end

  private

  def draw_ynq(msg)
    loop do
      print msg
      scn = gets.chomp

      return true if scn == 'Y'

      return false if scn == 'N'

      puts 'YかNを入力してください。'
    end
  end

  def one_que(jkr, game, hand)
    print "#{jkr.name}の"
    print "#{hand}の" if @hands.size > 1
    print "現在の得点は#{@card.scoring(hand.unqs)}です。"
    burst = @card.scoring(hand.unqs) > @card.limit
    puts 'バーストしました。' if burst
    return false if burst

    scn = draw_ynq("カードを引きますか？（Y/N）\n")
    game.need_card(self) if scn
    scn
  end
end
