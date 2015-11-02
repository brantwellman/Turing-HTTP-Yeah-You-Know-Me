# <pre>
# Verb: POST
# Path: /
# Protocol: HTTP/1.1
# Host: 127.0.0.1
# Port: 9292
# Origin: 127.0.0.1
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# </pre>

require "./lib/server"

hello_server = Server.new(9292)

request_lines = hello_server.client_request
puts request_lines

response = "Hello World (#{request_counter})"
hello_server.server_response(response)
