require_relative 'A'
require 'socket'

class Cc
  def initialize
    po = gets.chomp
    client = TCPSocket.open('localhost', po) # サーバーに接続する
    message = client.gets                     # サーバーからのメッセージを取得
    p message.date
    client.close 
  end
end
Cc.new