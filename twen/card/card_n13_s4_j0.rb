# frozen_string_literal: true

# @param none
class CardN13S4J0
  def len
    52
  end

  def suit(uniq)
    # suit = %i[spring summer autumn winter]
    suit = %i[クラブ ダイヤ ハート スペード]
    suit[(uniq / 13)]
  end

  def numb(uniq)
    uniq % 13 + 1
  end
end
