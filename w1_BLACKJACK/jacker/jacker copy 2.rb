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
        break unless action_que(game, hand)
        break unless pull_que(game, hand)
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

  def action_que(game, hand)
    burst = @card.scoring(hand.unqs) > @card.limit
    return false if burst

    str = @hands.size > 1 ? "#{hand}の" : ''
    print "#{@name}の#{str}現在の得点は#{@card.scoring(hand.unqs)}です。\n"
    cho = %w[何もしない サレンダー ダブルダウン]
    cho << 'スプリット' if @card.scoring([hand.unqs[0]]) == @card.scoring([hand.unqs[1]])
    c_ind = choice_que(cho)
    act_branch(game, c_ind)
  end

  def act_branch(game, c_ind)
    case c_ind
    when 0
      1
    when 1
      false
    when 2
      game.need_card(self)
      1
    when 3
      @hands << Hand.new(@hands[0].unqs.pop)
      false
    end
  end

  def pull_que(game, hand)
    str = @hands.size > 1 ? "#{hand}の" : ''
    print "#{@name}の#{str}現在の得点は#{@card.scoring(hand.unqs)}です。"
    burst = @card.scoring(hand.unqs) > @card.limit
    puts 'バーストしました。' if burst
    return false if burst

    scn = draw_ynq("カードを引きますか？（Y/N）\n")
    game.need_card(self) if scn
    scn
  end

  def choice_que(array)
    puts '次の選択肢から選んでください。'
    array.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end
    how_many('', 1..(array.size)) - 1
  end

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
end
