# frozen_string_literal: true

# @param none
module Console
  def ynq(msg)
    loop do
      print msg
      scn = gets.chomp

      return true if scn == 'Y'

      return false if scn == 'N'

      puts 'YかNを入力してください。'
    end
  end

  def choice_que(array)
    array.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end
    print '選択肢から選んでください。'
    how_many('', 1..(array.size)) - 1
  end

  def how_many(msg, rang)
    x = rang.min
    xn = rang.max
    loop do
      print "#{msg} (#{x}~#{xn})\n"
      scn = gets.chomp.to_i

      return scn if rang.cover?(scn)

      puts "(#{x}~#{xn})内で入力してください。"
    end
  end
end
