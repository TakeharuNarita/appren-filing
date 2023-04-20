# frozen_string_literal: true

require_relative '../../module/camel_snake_resolver'
require_relative 'hand'
# @param none
class Jacker
  extend CamelSnakeResolver
  def self.constant(constant_symbol) # rubocop:disable Metrics/MethodLength
    begin
      require_relative "./#{snakeization constant_symbol}"
    rescue LoadError
      "require_relative \"./#{snakeization constant_symbol}\""
    end
    case constant_symbol # TODO: hashmap
    when :PersonPlayer
      PersonPlayer
    when :NpcPlayer
      NpcPlayer
    when :NpcDealer
      NpcDealer
    else
      raise NoMethodError, "Need to add constants to class: '#{self}', constant_symbol: '#{constant_symbol}'"
    end
  end

  def initialize(con,game)
    @hand = Hand.new
    @connection = con # TODO: bat
    @game = game # TODO: bat
  end

  def draw(val)
    @hand.push val
    @connection.pull_msg val, self, nil
  end

  def score
    @game.scoring(@hand.map)
  end

  def want?
    not_implement unless inheritance?
    no_method(__method__)
  end

  def score_print
    @connection.now_score score, self, nil
  end

  def total_score_print
    @connection.total_score score.nil? ? 0 : score, self
  end

  private

  def inheritance?
    self.class.superclass != Object
  end

  def no_method(method_name)
    raise NoMethodError, "method '#{method_name}' not Overridden in '#{self.class.superclass}' subclass."
  end

  def not_implement
    raise NotImplementedError, "Inherit and use class '#{self.class}'"
  end
end

# Jacker.constant(:hogehoge)
