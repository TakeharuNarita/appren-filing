# rubocop:disable Metrics/MethodLength
# rubocop: Metrics/MethodLength
# TODO: jsonに置き換えるまでなので、jsonファイルの形式に合わせに行く

# frozen_string_literal: true

# @param noneを終了します。
module Words
  # @param none
  class Japanese
    class << self
      def console
        {
          open: '{{ game }}を開始します。',
          close: '{{ game }}を終了します。',
          draw: '{{ name }}の引いたカードは{{ suit }}の{{ num }}です。',
          dont_know: '{{ name }}の引いた{{ index }}枚目のカードはわかりません。',
          score: '{{ name }}の{{ now }}得点は{{ score }}です。',
          draw?: '#カードを引きますか？（Y/N）',
          know: '{{ name }}の引いた{{ index }}枚目のカードは{{ suit }}の{{ num }}でした。',
          you_win: '#あなたの勝ちです！',
          winner: '{{ name }}の勝ちです。',
          choice: '選択肢: ',
          how_many_npc: 'NPCの人数を入力してください。(0 ~ 3)',
          how_many_bet: 'ベットする金額を入力してください。(1 ~ {{ cache }})',
          invalid_input: '入力が不正です。'
        }
      end

      def handle
        {
          cache_total: '所持金の合計は ${{ cache }} です。',
          cache_bet: '所持金 ${{ cache }} からベットにより ${{ val }} を引き落としました。',
          cache_ret: '所持金 ${{ cache }} へリターンにより ${{ val }} の払い出しを受けました。'
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
          npc_dealer: 'ディーラー{{ num }}',
          npc_player: 'NPCプレイヤー{{ num }}',
          you: 'あなた'
        }
      end

      def game
        {
          one21: 'ブラックジャック'
        }
      end
    end
    def replace(word, hash)
      word = String.new(word)
      hash.keys.inject(word) do |str, key|
        reg = /{{ #{key} }}/
        str.gsub(reg, hash[key].to_s) if str.match(reg)
      end
    end
  end
end

# rubocop:enable Metrics/MethodLength
