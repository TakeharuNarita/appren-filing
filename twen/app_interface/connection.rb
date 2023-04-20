# rubocop:disable Style/MultilineTernaryOperator
# frozen_string_literal: true

require_relative '../module/camel_snake_resolver'
require_relative '../module/yes_no_question'
require_relative '../user_interface/console'
require_relative '../game/twentyone'
# @param none
class Connection
  include YesNoQuestion
  def initialize(uis_len)
    # ブラックジャックを開始します。
    puts 'ブラックジャックを開始します。'
    @game = Twentyone.new([[:CardN13S4J0, 1], [:PersonPlayer, :NpcDealer, :NpcPlayer, :NpcPlayer]]) # rubocop:disable Style/SymbolArray
    # @game = Twentyone.new
    @game.connection = self
    @roles = @game.jackers_assign
    @game.opening

    @game.first_pull
    # あなたの引いたカードはハートの7です。
    # ディーラーの引いたカードはダイヤのQです。
    # ディーラーの引いた2枚目のカードはわかりません。
    # def pull_msg()

    @game.add_or_not

    # あなたの現在の得点は15です。カードを引きますか？（Y/N）
    # now_score(msg, who, everyone)
    # Y
    # pull_que

    @game.ending
    # あなたの得点は20です。
    # ディーラーの得点は22です。
    # あなたの勝ちです！
    # ブラックジャックを終了します。
    puts 'ブラックジャックを終了します。'
  end

  def pull_msg(msg, who, everyone)
    if @roles[0] == who
      puts "あなたの引いたカードは#{@game.card.suit msg}の#{@game.card.numb msg}です。"
    else
      puts !everyone ? "#{cnv_jk(who.class)}の引いた2枚目のカードはわかりません。"\
      : "#{cnv_jk(who.class)}の引いたカードは#{@game.card.suit everyone}の#{@game.card.numb everyone}です。"
    end
  end

  def now_score(msg, who, everyone)
    if @roles[0] == who
      print "あなたの現在の得点は#{msg}です。"
    elsif everyone
      puts "#{cnv_jk(who.class)}の現在の得点は#{msg}です。"
    end
  end

  def total_score(msg, who)
    if @roles[0] == who
      puts "あなたの得点は#{msg}です。"
    else
      puts "#{cnv_jk(who.class)}の得点は#{msg}です。"
    end
  end

  def winner_only(who)
    if @roles[0] == who
      puts 'あなたの勝ちです！'
    else
      puts "#{cnv_jk(who.class)}の勝ちです。"
    end
  end

  def winner_none
    puts '勝者はいません、全員バーストしました。'
  end

  def winner_draw(*)
    puts 'draw'
  end

  def cnv_jk(whoclass)
    jknames = {
      NpcDealer => 'ディーラー',
      NpcPlayer => 'NPC'
    }
    jknames[whoclass]
  end

  def release_msg(msg, who)
    puts "#{cnv_jk(who.class)}の引いた2枚目のカードは#{@game.card.suit msg}の#{@game.card.numb msg}でした。"
  end

  def pull_que
    puts 'カードを引きますか？（Y/N）'
    ynq gets.chomp
  end
end

Connection.new(nil)

# rubocop:enable Style/MultilineTernaryOperator
