require 'socket'

tcp_server = TCPServer.new(9292)
client = tcp_server.accept
request_counter = 0
loop do
  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  # client = tcp_server.accept
  # request_counter = 0
  #
  unless request_lines.first == "GET /favicon.ico HTTP/1.1"
    request_counter += 1
  end
  #   client.puts "hello! #{request_counter}"

    # client.close

  puts "Got this request:"
  puts request_lines.inspect

  puts "Sending response."


  response = "Hello World (#{request_counter})"
  puts response
  # response = "<pre>" + request_lines.join("\n") + "</pre>"
  output = "<html><head></head><body>#{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output
end
puts ["Wrote this response:", headers, output].join("\n")
client.close
puts "\nResponse complete, exiting."
