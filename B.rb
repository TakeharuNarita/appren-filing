require_relative 'A'
require 'socket'

class Bb
  def initialize
    po = rent_private_port
    p po
    a = Aa.new
    a.date = "hoge"
    server = TCPServer.new po
    client = server.accept
    client.puts a
    client.close 
  end

  def rent_private_port
    find_port 49152..65535 # Dynamic/private port number (IANA)
  end

  def find_port(reng)
    reng.find { port_can_use? _1 }
  end

  def port_can_use?(port)
    begin
      server = TCPServer.new('localhost', port)
      server.close
      return true
    rescue Errno::EADDRINUSE
      return false
    end
  end
end

p Bb.new.rent_private_port
