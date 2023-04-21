# rubocop:disable Lint/InterpolationCheck, Metrics/MethodLength
# frozen_string_literal: true

# @param noneを終了します。
module Words
  # @param none
  class Japanese
    class << self
      def console
        {
          opn: '{{ game }}を開始します。',
          end: '{{ game }}を終了します。',
          draw: '{{ name }}の引いたカードは{{ suit }}の{{ num }}です。',
          dont_know: '{{ name }}の引いた{{ index }}枚目のカードはわかりません。',
          score: '{{ name }}の{{ now }}得点は{{ score }}です。',
          draw?: '#カードを引きますか？（Y/N）',
          know: '{{ name }}の引いた{{ index }}枚目のカードは{{ suit }}の{{ num }}でした。',
          you_win: '#あなたの勝ちです！',
          winner: '{{ name }}の勝ちです。'
        }
      end

      def card
        {
          spring: 'クラブ',
          summer: 'ダイヤ',
          autumn: 'ハート',
          winter: 'スペード',
          num1: 'エース',
          numb11: 'J',
          numb12: 'Q',
          numb13: 'K'
        }
      end

      def jacker
        {
          npc_dealer: 'NPCディーラー{{ num }}',
          npc_player: 'NPCプレイヤー{{ num }}',
          you: 'あなた'
        }
      end
    end
    def replacement(str, hash)
      {
        game: 'default_value',
        name: 'default_value',
        suit: 'default_value',
        num: 'default_value',
        index: 'default_value',
        now: 'default_value',
        score: 'default_value',
        you: 'default_value',
      }
    end
  end
end

# rubocop:enable Lint/InterpolationCheck, Metrics/MethodLength
