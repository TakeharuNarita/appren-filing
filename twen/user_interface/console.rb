# frozen_string_literal: true

# @param none
class Console
  attr_accessor :cono # TEST

  def conop
    p "#{self.class} #{@cono}: #{@connection}"
  end

  def initialize(connection)
    @connection = connection
    @cono = to_s # TEST
  end
end
