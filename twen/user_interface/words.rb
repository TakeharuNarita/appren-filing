# rubocop:disable Lint/InterpolationCheck, Metrics/MethodLength
# frozen_string_literal: true

# @param none
module Words
  # @param none
  class Japanese
    class << self
      def console
        {
          opn: '{{ game }}を開始します。',
          end: '#{game}を終了します。',
          draw: '#{name}の引いたカードは#{suit}の#{num}です。',
          dont_know: '#{name}の引いた#{index}枚目のカードはわかりません。',
          score: '#{name}の#{now}得点は#{score}です。',
          draw?: '#カードを引きますか？（Y/N）',
          know: '#{name}の引いた#{index}枚目のカードは#{suit}の#{num}でした。',
          you_win: '#あなたの勝ちです！',
          winner: '#{name}の勝ちです。'
        }
      end
      
      def suit
      {
        sor
      }
    end
    end
    def replacement(hash)
      {
        game: 'default_value',
        name: 'default_value',
        suit: 'default_value',
        num: 'default_value',
        index: 'default_value',
        now: 'default_value',
        score: 'default_value',
        you: 'default_value'
      }
    end
  end
end

# rubocop:enable Lint/InterpolationCheck, Metrics/MethodLength
