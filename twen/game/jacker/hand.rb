# frozen_string_literal: true

# @param none
class Hand
  def initialize
    @tags = []
  end

  def push(val)
    @tags.push val
  end

  def index(ind)
    @tags[ind]
  end

  def map
    @tags
  end
end
