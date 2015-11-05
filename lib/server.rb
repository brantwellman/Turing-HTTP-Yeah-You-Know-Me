require 'socket'
require 'pry'

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
    @request_lines
  end

  def game_client_request
    puts "Ready for a game request"
    @request_lines_game = []
    line_number = false
    while line = @client.gets and !line_number
      # puts line
      # binding.pry
      @request_lines_game << line.chomp
      # binding.pry
      line_number = (line == "0" || line.to_i > 0)
    end
    puts @request_lines_game
    # binding.pry
    @request_lines_game
  end

  def server_response(response)
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
  end

  def game_server_response
    binding.pry
    output = "<html><head></head><body></body></html>"
    headers = ["http/1.1 302 found",
              "Location: http://127.0.0.1:9292/game",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
  end

  def close_server
    @client.close
  end
end
