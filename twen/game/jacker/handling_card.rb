# frozen_string_literal: true

# @param none
class HandingCard
  attr_accessor :card_unq, :permission

  def initialize(unq)
    @card_unq = unq
    @permission = 444
  end
end
