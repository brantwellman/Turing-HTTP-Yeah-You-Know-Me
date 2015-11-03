require './lib/server'
require './lib/server_decorator'
require 'date'

hello_server = ServerDecorator.new(Server.new(9292))

request_counter = 0
hello_counter = 0

loop do
  request_lines = hello_server.client_request
  unless request_lines.first == "GET /favicon.ico HTTP/1.1"
    request_counter += 1
  end

  path = hello_server.request_path(request_lines)

  if path == "/"
    response = hello_server.request_output(request_lines)
  elsif path == "/hello"
    unless request_lines.first == "GET /favicon.ico HTTP/1.1"
      hello_counter += 1
    end
    response = "Hello World (#{hello_counter})"
  elsif path == "/datetime"
    now_time = DateTime.now
    response = now_time.strftime('%H:%M%p on %A, %B %d, %Y')
  elsif path == "/shutdown"
    response = "Total Requests #{request_counter}"
    hello_server.server_response(response)
    break
  end
  hello_server.server_response(response)
end

hello_server.close_server
