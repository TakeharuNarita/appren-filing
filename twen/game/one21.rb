# frozen_string_literal: true

require_relative '../user_interface/words'
require_relative '../game/off21'
require_relative '../module/camel_snake_resolver'
require_relative '../game/mountain'
# @param none
class One21 < Off21
  include CamelSnakeResolver

  def initialize(consoles)
    super
    @consoles = consoles
    @jackers = []
    @mountain = Mountain.new(:CardN13S4J0, 1)
  end

  def opening
    @mountain.shuffle
    jackers_new(:PersonPlayer)
    jackers_new(:NpcDealer)
    # 人数を入力してください。
    how_many_npc.times { jackers_new(:NpcPlayer) }
    # 賭け金を入力してください。
    how_many_bet
    self
  end

  def draws
    @jackers.each do |j|
      j.hands.each do |h|
        2.times do
          draw(h, j)
        end
      end
      draw_know(j)
    end
    self
  end

  def draws_loop
    @jackers.each do |j|
      j.hands.each do |h|
        loop do
          @consoles[j.location_num - 1].console_msg_one :score, { name: j.name, now: '現在の', score: h.score }
          break if h.burst?

          # 3択の質問を出す
          break unless h.want?

          h.add @mountain.pull
          h.map.last.permission = j.permissions(h.map.length - 1)
        end
      end
    end
    self
  end
end
