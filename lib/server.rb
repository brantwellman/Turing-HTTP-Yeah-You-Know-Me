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
    @request_lines
  end

  # def request_output
  #   verb = @request_lines[0].split(" ")[0]
  #   path = @request_lines[0].split(" ")[1]
  #   protocol = @request_lines[0].split(" ")[2]
  #   host = @request_lines.select {|line| line.start_with?("Host:") }[0].split(":")[1].strip
  #   port = @request_lines.select {|line| line.start_with?("Host:") }[0].split(":")[2]
  #   origin = host
  #
  #   accept = @request_lines.select {|line| line.start_with?("Accept:") }[0]
  #
  #   "<pre>" + "Verb: #{verb}\nPath: #{path}\nProtocol: #{protocol}\nHost: #{host}\nPort: #{port}\nOrigin: #{origin}\n#{accept}\n"  + "</pre>"
  # end
  #
  # def request_path
  #   @request_lines[0].split(" ")[1]
  # end

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

  def close_server
    @client.close
  end
end
