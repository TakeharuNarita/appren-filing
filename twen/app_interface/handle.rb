# frozen_string_literal: true

require_relative '../user_interface/words'
require_relative '../game/one21'
require_relative '../module/camel_snake_resolver'
# @param none
class Handle
  include CamelSnakeResolver
  attr_reader :cache

  def initialize
    @words = Words::Japanese.new
    @cache = 100
    msg = @words.class.handle[:cache_total]
    puts @words.replace(msg, { cache: @cache.to_s })
  end

  def run
    # TODO: self = console = USER
    game = One21.new([self])
    gam = Words::Japanese.game[(snake game.class.name).to_sym]
    # '{{ game }}を開始します。'
    puts @words.replace @words.class.console[:open], { game: gam }
    game.opening.rep
  end

  def console_msg(msg, repl = {})
    puts @words.replace Words::Japanese.console[msg], repl
  end

  def closed_question(choice, msg, repl = {})
    puts @words.replace Words::Japanese.console[msg], repl
    print Words::Japanese.console[:choice]
    choice.each { print _1 }
    puts
    gets.chomp
  end

  def open_question(msg, repl = {})
    puts @words.replace Words::Japanese.console[msg], repl
    gets.chomp
  end

  def jacker_str(msg, repl = {})
    @words.replace Words::Japanese.jacker[msg], repl
  end

  def cache_bet=(val)
    msg = @words.class.handle[:cache_bet]
    puts @words.replace msg, { cache: @cache.to_s, val: val.to_s }
    @cache -= val
  end

  def cache_ret=(val)
    msg = @words.class.handle[:cache_ret]
    puts @words.replace msg, { cache: @cache.to_s, val: val.to_s }
    @cache += val
  end
end


Handle.new.run
