# frozen_string_literal: true

# @param none
module YesNoQuestion
  def ynq(str)
    ar_yes = %w[y ye yes Y YE YES ｈ は はい h ha hai]
    ar_no = %w[n no N NO い いい いいえ i ii iie]
    (0..ar_yes.size).each do
      return true if ar_yes[_1] == str
      return false if ar_no[_1] == str
    end
    nil
  end
end
