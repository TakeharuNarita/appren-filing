# frozen_string_literal: true

# @param none
class CardN13S4J0
  def len
    52
  end

  def suit(uniq)
    suit = %i[spring summer autumn winter]
    suit[(uniq / 13)]
  end

  def width(uniq)
    uniq % 13
  end

  def num(uniq)
    uniq % 13 + 1
  end
end
