# frozen_string_literal: true

require_relative '../../module/camel_snake_resolver'
require_relative 'hand'
# @param none
class Jacker
  extend CamelSnakeResolver
  attr_accessor :location_num, :hands

  def initialize(con, game)
    @hand = Hand.new
    @hands = [Hand.new]
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
