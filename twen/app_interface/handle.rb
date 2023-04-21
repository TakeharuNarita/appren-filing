# frozen_string_literal: true

require_relative '../user_interface/words'
# @param none
class Handle
  def initialize
    @words = Words::Japanese
    game = "ゲーム"
    pri = String.new(@words.console[:opn])
    pri.slice!(0)
    p pri
  end
  def get_handle
    @handle
  end

  def set_handle(handle)
    @handle = handle
  end
end

Handle.new
