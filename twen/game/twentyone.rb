# frozen_string_literal: true

require_relative 'mountain'
require_relative '../card/cards'
require_relative './jacker/jacker'
# @param none
class Twentyone
  attr_reader :card
  attr_writer :connection

  def initialize(defi = [[:CardN13S4J0, 1], [:PersonPlayer, :NpcDealer]]) # rubocop:disable Style/SymbolArray
    @defi = defi
    @upper_limit = 21
  end

  def jackers_assign
    @jackers = []
    @defi[1].each do
      @jackers.push Jacker.constant(_1).new(@connection, self)
    end
    @jackers
  end

  def opening # rubocop:disable Metrics/AbcSize, Lint/RedundantCopDisableDirective
    @card = Cards.constant(@defi[0][0]).new # TODO: newする必要なし
    @mountain = Mountain.new(@card, @defi[0][1]) # TODO: json
    @mountain.shuffle
  end

  def first_pull
    @jackers.each do |jacker|
      2.times { draw_a_card jacker }
    end
  end

  def add_or_not
    @jackers.each do |jacker|
      jacker.second_release if jacker.respond_to?(:second_release)
      loop do
        break unless jacker.score
        break unless jacker.want?

        draw_a_card jacker
      end
    end
  end

  def ending
    @jackers.each { _1.total_score_print }
    score_map = @jackers.map(&:score)

    max_score = score_map.map{ _1.nil? ? 0 : _1 }.max

    win_inds = []
    score_map.each_with_index { win_inds << _2 if _1 == max_score }
    if win_inds.length == 1
      @connection.winner_only @jackers[win_inds[0]]
    elsif win_inds.empty?
      @connection.winner_none
    elsif win_inds.length > 2
      @connection.winner_draw(win_inds.map { @jackers[_1] })
    end
  end

  def scoring(unqs)
    nums = unqs.map { |num| card.numb(num) > 10 ? 10 : card.numb(num) }
    patterns = [nums.sum]
    patterns << nums.sum + 10 if nums.include?(1)
    patterns.select { |pattern| pattern <= @upper_limit }.max
  end

  private

  def draw_a_card(jkr)
    jkr.draw @mountain.pull
  end
end

# p Twentyone.new.opening
