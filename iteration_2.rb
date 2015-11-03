require "./lib/server"

hello_server = Server.new(9292)

request_counter = 0

loop do
  request_lines = hello_server.client_request

  unless request_lines.first == "GET /favicon.ico HTTP/1.1"
    request_counter += 1
  end

  response = "Hello World (#{request_counter})"
  hello_server.server_response(response)
end

hello_server.close_server
