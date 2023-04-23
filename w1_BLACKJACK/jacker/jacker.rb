# frozen_string_literal: true

require_relative '../game/console'

require_relative 'hand'
# @param none
class Jacker
  include Console
  attr_accessor :hands, :name, :role

  def initialize(game)
    @game = game
    @card = game.card
    @hands = [Hand.new(@card)]
    @role = :player
  end

  def hit(unq, hand_index = 0)
    @hands[hand_index].hit(unq)
    print "カードは#{@card.suit(unq)}の#{@card.rank(unq)}です。"
  end

  def totals(now: false)
    @hands.each_index { puts total(_1, now) }
  end

  def total(index = 0, now = false) # rubocop:disable Style/OptionalBooleanParameter
    str1 = @hands.size > 1 ? "手札#{@hands[index].name}の" : ''
    str2 = now ? '現在の' : ''
    "#{@name}の#{str1}#{str2}得点は#{@hands[index].score}です。"
  end

  def act_que
    totals
    cho = %w[何もしない サレンダー ダブルダウン]
    cho << 'スプリット' # if @card.scoring([@hands[0].unqs[0]]) == @card.scoring([@hands[0].unqs[1]])
    c_ind = choice_que(cho)
    act_branch(c_ind)
  end

  def act_branch(c_ind)
    case c_ind
    when 0
      ac_none
    when 1
      ac_surrender
    when 2
      ac_doble_down
    when 3
      ac_split
    end
  end

  def ac_none(hand_index = 0)
    loop do
      print total(hand_index, now: true)
      bur = @hands[hand_index].burst?
      puts 'バーストしました。' if bur
      break if bur

      scn = ynq("カードを引きますか？（Y/N）\n")
      @game.need_card(self, hand_index) if scn
      break unless scn
    end
  end

  def ac_doble_down(hand_index = 0)
    @game.need_card(self)
    puts total(hand_index, now: true)
    bur = @hands[hand_index].burst?
    puts 'バーストしました。' if bur
  end

  def ac_split(hand_index = 0)
    hand = Hand.new(@card, hand_index + 2)
    hand.unqs << @hands[hand_index].unqs.pop
    @hands << hand
    @hands.each_index { ac_none(_1) }
  end

  def ac_surrender
    puts 'サレンダーしました。'
    @game.surrender(self)
  end

  def loser
  end
end
