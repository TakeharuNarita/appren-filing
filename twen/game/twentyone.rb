# frozen_string_literal: true

require_relative 'mountain'
# @param none
class Twentyone
  def initialize(defi = [:CardN13S4J0, [:PersonPlayer], [:NpcDealer]])
    mountain = Mountain.new(defi[0])
  end
end