# frozen_string_literal: true

# @param none
class Card
  attr_accessor :limit, :len, :wide

  def initialize(limit)
    @limit = limit
    @len = limit / 21 * 52
    @wide = 13
  end

  def num(unq)
    unq % @wide + 1
  end

  def rank(unq)
    ranks = %w[A 2 3 4 5 6 7 8 9 10 J Q K]
    ranks[num(unq) - 1]
  end

  def suit(unq)
    suits = %w[クラブ ハート ダイヤ スペード]
    suits[unq / @wide]
  end

  def scoring(unqs)
    nums = unqs.map { |unq| num(unq) > limit / 21 * 10 ? 10 : num(unq) }
    patterns = [nums.sum]
    patterns << nums.sum + 10 if nums.include?(1)
    patterns.select { |pattern| pattern <= @limit }.max || patterns.min
  end

  def burst?(unqs)
    scoring(unqs) > @limit
  end
end
