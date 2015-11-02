require 'socket'

class Server
  def initialize(port_number)
    tcp_server = TCPServer.new(port_number)
    @client = tcp_server.accept
  end

  def client_request
    puts "Ready for a request"
    @request_lines = []
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end
end

my_server = Server.new(9292)
loop do
my_server.client_request
